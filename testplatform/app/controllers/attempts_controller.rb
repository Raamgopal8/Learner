class AttemptsController < ApplicationController
  def create
    user_id = params[:user_id]
    test_id = params[:test_id]
    answers = params[:answers] || {}

    # Get all correct answers for this test
    correct_answers = DB.exec_params("SELECT id, correct_answer FROM questions WHERE test_id = $1;", [test_id])

    score = 0
    total = correct_answers.ntuples

    correct_answers.each do |q|
      qid = q['id']
      correct = q['correct_answer']
      user_answer = answers[qid]

      score += 1 if user_answer == correct
    end

    # Store attempt record
    DB.exec_params(
  "INSERT INTO attempts (user_id, test_id, score, total_points, user_answers, submitted_at)
   VALUES ($1, $2, $3, $4, $5, NOW());",
  [user_id, test_id, score, total, answers.to_json]
)

    redirect_to "/results?score=#{score}&total=#{total}"
  end
end
