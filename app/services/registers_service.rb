class RegistersService
  def initialize user = nil, major_id = nil
    @user = user
    @major_id = major_id
    @department_id = set_best_depart if @user
  end

  def get_mark_from_depart
    department = Department.find_by id: @department_id
    subject_ids = department.subjects.pluck :id
    @user.results.get_by_subject(subject_ids).sum :mark
  end

  def get_best_depart
    @department_id
  end

  def set_best_depart
    department_ids = MajorDepartment.get_by_major(@major_id).pluck :department_id
    Result.mark_department_best(department_ids, @user.id).first.department_id
  end

  def convert_array2string ids
    str = "("
    ids.each_with_index do |id, i|
      str += (i != ids.size - 1) ? "#{id}, " : "#{id})"
    end
    str
  end
end
