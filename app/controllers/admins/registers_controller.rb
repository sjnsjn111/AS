class Admins::RegistersController < Admins::AdminsController
  before_action :load_user, only: %i(new edit update create)
  before_action :load_user_registers, only: :edit
  before_action :load_major_valid, only: %i(new edit)

  def new
    3.times do
      @user.registers.build
    end
  end

  def create
    if @user.update_attributes register_params
      @success = t "updated_registers"
      load_user_registers
    end
  end

  def edit; end

  def update
    if @user.update_attributes register_params
      @success = t "updated_registers"
      load_user_registers
    end
  end

  def import
    if params[:file].present?
      Register.import_file params[:file]
      @success = t "import_success"
    else
      @error = t "not_file"
    end
  rescue
    @error = t "import_fail"
  end

  private

  def register_params
    3.times do |n|
      next if params[:user][:registers_attributes]["#{n}"][:major_id].blank?
      @mark = get_department_best params[:user][:registers_attributes]["#{n}"][:major_id]
      params[:user][:registers_attributes]["#{n}"]
        .merge!(mark: @mark.round(1), department_id: @department)
    end
    params.require(:user).permit registers_attributes: %i(id major_id department_id mark department_id)
  end

  def load_user
    @user = User.find_by id: params[:id]
    raise ActiveRecord::RecordNotFound unless @user
  end

  def load_major_valid
    department_ids = @user.find_user_departments
    major_ids = MajorDepartment.get_by_depart(department_ids).pluck :major_id
    @majors = Major.get_by major_ids
  end

  def get_department_best major_id
    get_department = RegistersService.new @user, major_id
    @department = get_department.get_best_depart
    get_department.get_mark_from_depart
  end
end
