class StatisticResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    @average_results = Department.average_results_by_departments
    @results_user = current_user.results.includes :subject
    @total = @results_user.pluck(:mark).inject(0){|sum,x| sum + x} if @results_user.present?
    @rank = Result.rank current_user.id
    @average_marks = Result.group(:mark).size
  end
end
