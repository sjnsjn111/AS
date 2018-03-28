class RemarkingMailer < ApplicationMailer
  def reject_remarking file_remarking
    @user = file_remarking.user
    @url = root_url
    mail to: @user.email, subject: t("remarking_title_mail")
  end

  def processed_remarking file_remarking
    @user = file_remarking.user
    @url = root_url
    mail to: @user.email, subject: t("remarking_title_mail")
  end
end
