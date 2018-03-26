class Admins::UsersController < Admins::AdminsController
  before_action :find_user, only: %i(show destroy)
  before_action :load_result, only: :show
  before_action :build_user, only: :index

  def index
    if params[:q] && params[:q][:role] == Settings.teacher || params[:role] == Settings.teacher
      load_teachers
    else
      load_students
    end
  end

  def create
    @user = User.new user_params
    get_password
    if @user.save
      notification
      after_handlind_user
      @success = t "created_user"
    else
      @error = t "created_user_error"
    end
  end

  def destroy
    unless @error
      if @user.destroy
        after_handlind_user
        @success = t "deleted_success"
      else
        @message = t "deleted_failure"
      end
    end
  end

  def import_students
    User.transaction do
      User.import params[:file]
      notification
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
    @q = User.student.user_newest.search params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def load_teachers
    @q = User.teacher.user_newest.search params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def build_user
    @user = User.new role: params[:role]
  end

  def user_params
    params.require(:user).permit :birthday, :address, :phone,
      :religion, :nation, :nationality, :name, :identification_number,
      :email, :people_id, :role, :school_id
  end

  def find_user
    redirect_to action: "index" if params[:page]
    @user = User.find_by id: params[:id]
    return if @user
    @error = t "nil_user"
  end

  def load_result
    @results = @user.results.includes(:subject)
  end

  def notification
    user_read = User.get_not_role(:student).pluck(:id)
    user_read.delete(current_user.id) if current_user
    Notification.create_notification user_read, current_user, :add_student
  rescue ActiveRecord::RecordInvalid
  end

  def get_password
    if @user.student? && params[:user] && params[:user][:people_id] && params[:user][:identification_number]
      @user.password = params[:user][:people_id] + params[:user][:identification_number]
    else @user.teacher? && params[:user] && params[:user][:people_id]
      @user.password = params[:user][:people_id]
    end
  end

  def after_handlind_user
    if @user.student?
      load_students
    else
      load_teachers
    end
  end
end
