class StatisticResultsController < BaseNotificationsController
  before_action :load_deparment, only: :show
  before_action :load_result_user, only: %i(index by_depart average_each_majors)
  before_action :get_depart_user, :load_best_result_by_depart, only: %i(index by_depart average_each_majors)
  before_action :get_major_ids, :load_schools, only: :average_each_majors

  def index
    @rank = Result.rank current_user.id
    @average_marks = Result.group(:mark).size
    @subjects = current_user.subjects
  end

  def show
    return if @error
    @average_marks = @average_marks.group(:mark).size
  end

  def by_depart
    @results_important = Department.average_results_by_departments @departments
    @average_results = {}
    @results_important.each do |x|
      @average_results[x.first] = x.second[:average]
    end
    get_method = RegistersService.new
    @rank_by_departments = {}
    @departments.each do |department|
      @rank_by_departments[department.name] = Result
        .rank_by_department get_method.convert_array2string(@results_important[department
        .name][:user_ids]), get_method.convert_array2string(department.subjects.pluck(:id)),
        current_user.id
    end
  end

  def average_each_majors
    aspiration = params[:aspirations].present? ? params[:aspirations] : :all
    @results = Register.send(aspiration).get_average_majors @major_ids
    @results = @results.sort_by {|name, value| value}
  end

  private

  def load_deparment
    if params[:department].present?
      department = Department.find_by id: params[:department]
      if params[:subjects].present?
        @average_marks = department.results.get_by_subject params[:subjects]
      else
        @average_marks = department.results
      end
    elsif params[:subjects].present?
      @average_marks = Result.get_by_subject params[:subjects]
    else
      @average_marks = Result.all
    end
    @subjects = department.present? ? department.subjects : current_user.subjects
  end

  def load_result_user
    @results_user = current_user.results.includes :subject
    @total = @results_user.pluck(:mark).inject(0){|sum,x| sum + x} if @results_user.present?
  end

  def get_depart_user
    @department_ids = current_user.find_user_departments
    @departments = Department.get_by @department_ids
  end

  def get_major_ids
    department_ids = params[:department].present? ? params[:department] : @department_ids
    if params[:schools].present?
      @major_ids = Major.get_by_school(params[:schools]).get_by_department(department_ids).pluck :id
    else
      @major_ids = Major.get_by_department(department_ids).pluck :id
    end
  end

  def load_schools
    @schools = School.all
  end

  def load_best_result_by_depart
    results = ResultsService.new current_user, @department_ids
    @result_best_depart = results.get_mark_best_depart
    @depart_best = Department.find_by id: @result_best_depart&.department_id
  end
end
