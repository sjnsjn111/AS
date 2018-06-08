class UserMailer < ApplicationMailer
  def import_user user
    @user = user
    @url = new_user_session_url
    mail to: @user.email, subject: t("welcome_to_adminssion_support")
  end
end
