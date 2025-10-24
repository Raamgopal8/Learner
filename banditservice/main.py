# bandit_service/main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import numpy as np
import psycopg2
import os
import json
from typing import List, Dict

# --- CONFIG (use env vars in production) ---
DB_NAME = os.getenv("BANDIT_PG_DB", "testplatform")
DB_USER = os.getenv("BANDIT_PG_USER", "postgres")
DB_PASS = os.getenv("BANDIT_PG_PASS", "password")
DB_HOST = os.getenv("BANDIT_PG_HOST", "localhost")
DB_PORT = int(os.getenv("BANDIT_PG_PORT", 5432))

# LinUCB hyperparameter
ALPHA = float(os.getenv("LINUCB_ALPHA", 1.0))  # exploration weight

# Connect to Postgres
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)
conn.autocommit = True

app = FastAPI(title="LinUCB Bandit Service")


# ---- Pydantic models ----
class RecommendRequest(BaseModel):
    user_id: int
    context: List[float]  # length d
    top_k: int = 3


class RecommendResponseItem(BaseModel):
    course_id: int
    score: float


class RecommendResponse(BaseModel):
    recommendations: List[RecommendResponseItem]


class RewardRequest(BaseModel):
    user_id: int
    course_id: int
    reward: float
    context: List[float]  # same context vector used for recommending


# ---- Helpers to load/save bandit state ----
def fetch_all_course_states():
    """Return dict course_id -> (d, A, b)"""
    cur = conn.cursor()
    cur.execute("SELECT course_id, d, A, b FROM bandit_states")
    rows = cur.fetchall()
    states = {}
    for course_id, d, A_json, b_json in rows:
        A = np.array(A_json).reshape((d, d))
        b = np.array(b_json).reshape((d,))
        states[course_id] = (d, A, b)
    cur.close()
    return states


def init_state_for_course(course_id: int, d: int):
    """Create bandit state for a course if missing"""
    cur = conn.cursor()
    # check exists
    cur.execute("SELECT 1 FROM bandit_states WHERE course_id=%s", (course_id,))
    if cur.fetchone():
        cur.close()
        return
    A = np.identity(d).tolist()
    b = [0.0] * d
    cur.execute(
        "INSERT INTO bandit_states (course_id, d, A, b) VALUES (%s, %s, %s, %s)",
        (course_id, d, json.dumps(A), json.dumps(b)),
    )
    cur.close()


def get_or_init_all_states(d: int):
    """Ensure bandit state exists for all courses, then return states dict"""
    cur = conn.cursor()
    # fetch all course ids
    cur.execute("SELECT id FROM courses")
    course_ids = [r[0] for r in cur.fetchall()]
    cur.close()
    for cid in course_ids:
        init_state_for_course(cid, d)
    return fetch_all_course_states()


def save_state(course_id: int, A: np.ndarray, b: np.ndarray):
    d = A.shape[0]
    cur = conn.cursor()
    cur.execute(
        "UPDATE bandit_states SET A=%s, b=%s, last_update=NOW() WHERE course_id=%s",
        (json.dumps(A.flatten().tolist()), json.dumps(b.tolist()), course_id),
    )
    cur.close()


# ---- LinUCB logic ----
def linucb_scores(states: Dict[int, tuple], x: np.ndarray, alpha: float):
    """
    states: course_id -> (d, A, b)
    x: context vector shape (d,)
    returns dict course_id->score
    """
    scores = {}
    for course_id, (d, A, b) in states.items():
        # ensure shapes
        A = np.array(A)
        b = np.array(b)
        A_mat = A.reshape((d, d))
        b_vec = b.reshape((d,))
        try:
            A_inv = np.linalg.inv(A_mat)
        except np.linalg.LinAlgError:
            A_inv = np.linalg.pinv(A_mat)
        theta = A_inv.dot(b_vec)  # d,
        exploit = float(np.dot(theta, x))
        explore = alpha * np.sqrt(float(x.T.dot(A_inv).dot(x)))
        scores[course_id] = exploit + explore
    return scores


# ---- API endpoints ----
@app.post("/recommend", response_model=RecommendResponse)
def recommend(req: RecommendRequest):
    x = np.array(req.context, dtype=float)
    d = x.shape[0]

    # ensure states exist for all courses
    states = get_or_init_all_states(d)

    # compute scores
    scores = linucb_scores(states, x, ALPHA)

    # sort and return top_k
    ranked = sorted(scores.items(), key=lambda kv: kv[1], reverse=True)
    top = ranked[: req.top_k]
    resp = [RecommendResponseItem(course_id=int(cid), score=float(score)) for cid, score in top]
    return {"recommendations": resp}


@app.post("/reward")
def reward(req: RewardRequest):
    x = np.array(req.context, dtype=float)
    d = x.shape[0]
    course_id = req.course_id
    r = float(req.reward)

    # fetch state for this course
    cur = conn.cursor()
    cur.execute("SELECT d, A, b FROM bandit_states WHERE course_id=%s LIMIT 1", (course_id,))
    row = cur.fetchone()
    if not row:
        cur.close()
        raise HTTPException(status_code=404, detail="Bandit state for course not found")
    d_db, A_json, b_json = row
    if d_db != d:
        cur.close()
        raise HTTPException(status_code=400, detail="Context dimension mismatch")
    A = np.array(A_json).reshape((d, d))
    b = np.array(b_json).reshape((d,))

    # LinUCB update: A <- A + x x^T ; b <- b + r x
    A = A + np.outer(x, x)
    b = b + r * x

    # persist
    save_state(course_id, A, b)

    # log reward
    cur.execute(
        "INSERT INTO bandit_rewards (user_id, course_id, reward, context) VALUES (%s, %s, %s, %s)",
        (req.user_id, course_id, r, json.dumps(req.context)),
    )
    cur.close()
    return {"status": "ok"}


# health
@app.get("/health")
def health():
    return {"status": "ok"}
