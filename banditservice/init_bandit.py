# bandit_service/init_bandit.py
import psycopg2, json, os
import numpy as np

DB_NAME = os.getenv("BANDIT_PG_DB", "testplatform")
DB_USER = os.getenv("BANDIT_PG_USER", "postgres")
DB_PASS = os.getenv("BANDIT_PG_PASS", "password")
DB_HOST = os.getenv("BANDIT_PG_HOST", "localhost")
DB_PORT = int(os.getenv("BANDIT_PG_PORT", 5432))

conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)
cur = conn.cursor()
conn.autocommit = True

# sample courses
courses = [
    ("Web Development", "Web Development Fundamentals", 1),
    ("Programming", "Languages", 1),
    ("Data Structures & Algorithms", "DSA", 1),
    ("Machine Learning", "Intro to Machine Learning", 1),
    ("UI/UX ", "UI/UX Design Principles", 1),
    ("Business", "Business Fundamentals", 1),
    ("Data Science", "Data Science Fundamentals", 1),
    ("Mobile Development","Mobile App Development",1),
]

for title, desc, diff in courses:
    cur.execute("INSERT INTO courses (title, description, difficulty_level) VALUES (%s, %s, %s) ON CONFLICT (title) DO NOTHING;", (title, desc, diff))

# get d from your chosen context dimension
d = 6
cur.execute("SELECT id FROM courses")
course_ids = [r[0] for r in cur.fetchall()]

for cid in course_ids:
    # create state if missing
    cur.execute("SELECT 1 FROM bandit_states WHERE course_id=%s", (cid,))
    if not cur.fetchone():
        A = np.identity(d).flatten().tolist()
        b = [0.0] * d
        cur.execute("INSERT INTO bandit_states (course_id, d, A, b) VALUES (%s,%s,%s,%s)", (cid, d, json.dumps(A), json.dumps(b)))

print("Initialized courses and bandit states.")
cur.close()
conn.close()
