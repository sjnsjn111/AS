class Teachers::UsersController < Teachers::TeachersController
  before_action :find_user, only: %i(show destroy edit update)
  before_action :load_notifications, only: :index

  def index
    load_students
  end

  def edit; end

  def update
    if @user && @user.update_attributes(user_params)
      @success = t "update_success"
    elsif @user
      @error = t "update_errors"
    end
  end

  private

  def load_students
    @q = User.student.user_newest.search params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def user_params
    params.require(:user).permit :birthday, :address, :phone,
      :religion, :nation, :nationality, :name, :identification_number,
      :email, :people_id
  end

  def find_user
    redirect_to action: "index" if params[:page]
    @user = User.find_by id: params[:id]
    return if @user
    @error = t "nil_user"
  end

  def notification
    user_read = User.get_not_role(:student).pluck(:id)
    user_read.delete(current_user.id) if current_user
    Notification.create_notification user_read, current_user, :add_student
  rescue ActiveRecord::RecordInvalid
  end
end
