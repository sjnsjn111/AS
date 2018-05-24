class UsersController < BaseNotificationsController
  before_action :current_ability
  before_action :load_user, only: %i(show edit update lock_account)
  before_action :load_aspiration, :load_results, only: :show
  before_action :load_notifications, only: :show
  load_and_authorize_resource param_method: :user_params

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        load_aspiration
        load_results
        format.js{@success = t "update_success"}
      else
        format.js{@errors = t "update_failure"}
      end
    end
  end

  def lock_account
    if @user.update_attributes(locked_at: DateTime.now)
      sign_out @user
      flash[:success] = t "locked_success"
      redirect_to new_user_session_path
    else
      flash[:danger] = t "locked_failure"
      redirect_to request.referer || root_url
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "nil_user"
    redirect_to root_url
  end

  def load_user_ajax
    @user = User.find_by id: params[:id]
    return if @user
    @error = t "nil_user"
  end

  def user_params
    params[:user][:sex] = params[:user][:sex].to_i if params[:user]
    params.require(:user).permit :birthday, :address, :phone, :avatar, :sex,
      :religion, :nation, :nationality
  end

  def load_aspiration
    return if @user.blank?
    @registers = @user.registers
  end

  def load_results
    @results = current_user.results
  end
end
