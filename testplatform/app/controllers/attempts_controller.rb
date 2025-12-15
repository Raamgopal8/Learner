require 'net/http'
require 'uri'
require 'json'

class AttemptsController < ApplicationController
  before_action :authenticate_user! # Protect this controller

  def create
    user_id = current_user.id # Securely get user ID
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

    # Fetch test category to use as target domain for boosting
    test_info = DB.exec_params("SELECT category FROM tests WHERE id=$1", [test_id]).first
    target_domain = test_info ? test_info['category'] : nil

    # call bandit service for recommendations
    uri = URI("http://localhost:8000/recommend")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    req.body = { 
      user_id: user_id, 
      context: context, 
      top_k: 3,
      target_domain: target_domain
    }.to_json
    resp = http.request(req)
    recommendations = JSON.parse(resp.body)['recommendations'] rescue []
    
    # Fetch course details for recommendations
    @recommended_courses = []
    recommendations.each do |rec|
      course_id = rec['course_id']
      # Fixed: 'domain' column does not exist, use 'category' instead
      course_row = DB.exec_params("SELECT id, title, category FROM courses WHERE id=$1", [course_id]).first
      if course_row
        @recommended_courses << {
          id: course_row['id'],
          title: course_row['title'],
          domain: course_row['category'], # Map category to domain for view compatibility
          category: course_row['category'],
          score: rec['score']
        }
      end
    end
    
    # Calculate performance metrics
    @score = score
    @total = total
    @percentage = ((score.to_f / total) * 100).round(2)
    @grade = calculate_grade(@percentage)
    @test_id = test_id
    
    # Render results page
    render 'result'
  end
  
  def calculate_grade(percentage)
    case percentage
    when 90..100 then 'A+'
    when 80...90 then 'A'
    when 70...80 then 'B+'
    when 60...70 then 'B'
    when 50...60 then 'C'
    when 40...50 then 'D'
    else 'F'
    end
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
