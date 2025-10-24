require 'net/http'
require 'uri'
require 'json'

class AttemptsController < ApplicationController
  def create
    user_id = params[:user_id].to_i
    test_id = params[:test_id].to_i
    answers = params[:answers] || {}

    # Fetch questions for the test
    questions = DB.exec_params("SELECT id, correct_answer FROM questions WHERE test_id=$1", [test_id]).to_a

    # Calculate score and total
    score = 0
    total = questions.size
    questions.each do |q|
      submitted_answer = answers[q['id'].to_s]
      score += 1 if submitted_answer && submitted_answer == q['correct_answer']
    end

    # Save attempt
    DB.exec_params("INSERT INTO attempts (user_id, test_id, score, total_points, submitted_at) VALUES ($1, $2, $3, $4, NOW())", [user_id, test_id, score, total])

    # Build context vector (must match microservice dimension)
    # Example features - compute from DB or compute ad-hoc here
    context = [
      (score.to_f / total),             # score_pct
      user_avg_score(user_id),          # avg_score (0..1) helper function below
      weak_topic_ratio(user_id),        # weak_topic ratio
      time_taken_ratio(params),         # computing placeholder
      difficulty_match(test_id),        # placeholder
      engagement_score(user_id)         # placeholder
    ].map(&:to_f)

    # call bandit service
    uri = URI("http://localhost:8000/recommend")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    req.body = { user_id: user_id, context: context, top_k: 3 }.to_json
    resp = http.request(req)
    recs = JSON.parse(resp.body)['recommendations'] rescue []

    # render results page with @score and @recs
    @score = score
    @total = total
    @recommendations = recs # array of {course_id, score}
    render 'result'
  end

  # Helper examples - implement your real computations
  def user_avg_score(user_id)
    res = DB.exec_params("SELECT AVG(score::float/NULLIF(total_points,0)) as avgp FROM attempts WHERE user_id=$1", [user_id])
    v = res[0] && res[0]['avgp']
    v ? v.to_f : 0.5
  end

  def weak_topic_ratio(user_id)
    # simplified: placeholder 0.2
    0.2
  end

  def time_taken_ratio(params)
    # placeholder 0.5
    0.5
  end

  def difficulty_match(test_id)
    # placeholder 0.0
    0.0
  end

  def engagement_score(user_id)
    0.3
  end
end
