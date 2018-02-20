class Admins::UsersController < Admins::AdminsController
  def index
    if params[:role] == Settings.teacher
      @teachers = User.teacher.user_newest.page(params[:page]).per Settings.per_page
    else
      load_students
      build_student
    end
  end

  def create
    @user = User.new user_params
    @user.role = params[:role]
    @user.password = params[:user][:people_id] + params[:user][:identification_number] if params[:user]
    if @user.save
      load_students
      @success = t "created_student"
    else
      @error = t "created_student_error"
    end
  end

  def import_students
    User.transaction do
      User.import params[:file]
      load_students
      @success = t "users_imported"
    end
  rescue ActiveRecord::RecordInvalid => exception
    @errors = [t("users_imported_error"), exception.message]
  rescue
    @errors = [t("users_imported_error"), t("file_illegal")]
  end

  private

  def load_students
    @students = User.student.user_newest.page(params[:page]).per Settings.per_page
  end

  def build_student
    @student = User.new role: params[:role]
  end

  def user_params
    params.require(:user).permit :birthday, :address, :phone,
      :religion, :nation, :nationality, :name, :identification_number,
      :email, :people_id
  end
end
