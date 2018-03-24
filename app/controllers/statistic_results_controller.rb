class StatisticResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    department_ids = current_user.find_user_departments
    departments = Department.get_by department_ids
    @average_results = Department.average_results_by_departments departments
    @results_user = current_user.results.includes :subject
    @total = @results_user.pluck(:mark).inject(0){|sum,x| sum + x} if @results_user.present?
    @rank = Result.rank current_user.id
    @average_marks = Result.group(:mark).size
  end
end
