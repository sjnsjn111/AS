class ResultsService
  def initialize user = nil, department_ids
    @user = user
    @department_ids = department_ids
  end

  def get_mark_best_depart
    department_ids = @user.find_user_departments
    Result.mark_department_best(department_ids, @user.id).first
  end
end
