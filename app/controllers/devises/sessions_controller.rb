class Devises::SessionsController < Devise::SessionsController

  def create
    if request.xhr?
      session["user_auth"] = params[:user]
      resource = warden.authenticate scope: resource_name
      if resource.blank?
        failure
      else
        sign_in resource_name, resource
        flash[:success] = I18n.t "devise.sessions.signed_in"

        yield resource if block_given?

        render json: {success: true, link_redirect: after_sign_in_path_for(resource),
          message: t("login_success")}
      end
    else
      super
    end
  end

  def failure
    user = User.where(email: session["user_auth"][:email]).first rescue nil
    @messages = {}
    check_locked_account(user.failed_attempts) if user.failed_attempts > 3
    @messages[:error] = I18n.t "devise.failure.invalid", authentication_keys: "email" unless user.access_locked?
    render :json => {success: false, messages: @messages}
  end

  private

  def check_locked_account failed_attempts
    case failed_attempts
    when 4
      @messages[:lock] = t "devise.failure.last_attempt"
    when 5
      @messages[:lock] = t "devise.failure.locked"
    end
  end
end
