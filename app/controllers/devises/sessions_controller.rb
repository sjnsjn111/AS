class Devises::SessionsController < Devise::SessionsController
  def create
    if request.xhr?
      @user = User.find_by email: params[:user][:email]
      if @user
        sign_in_user
      else
        failure
      end
    else
      super
    end
  end

  def failure
    message = t('login_invalid')
    render json: {success: false, message: message}
  end

  private

  def sign_in_user
    if @user.valid_password?(params[:user][:password])
      set_flash_message! :notice, :signed_in
      sign_in resource_name, @user
      flash[:success] = t 'login_success'
      render json: {success: true, link_redirect: after_sign_in_path_for(@user),
        message: t('login_success')}
    else
      failure
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def is_user_active?
    @user.confirmed_at
  end
end
