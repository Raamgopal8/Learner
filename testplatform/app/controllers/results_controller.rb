class ResultsController < ApplicationController
  def index
    @score = params[:score]
    @total = params[:total]
  end
end
