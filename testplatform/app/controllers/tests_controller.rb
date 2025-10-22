class TestsController < ApplicationController
  def index
    # Use DB to fetch tests
    @tests = DB.exec("SELECT * FROM tests ORDER BY created_at DESC").to_a
  end

  def show
    test_id = params[:id]
    @test = DB.exec_params("SELECT * FROM tests WHERE id=$1 LIMIT 1", [test_id]).first
    @questions = DB.exec_params("SELECT * FROM questions WHERE test_id=$1 ORDER BY id ASC", [test_id]).to_a
  end
end
