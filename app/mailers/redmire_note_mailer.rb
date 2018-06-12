class RedmireNoteMailer < ApplicationMailer
  def redmire_remarking users
    @users = users
    @url = file_remarkings_url
    mail to: @users.map(&:email).uniq, subject: t("redmire_remarking")
  end

  def redmire_aspiration users
    @users = users
    @url = root_url
    mail to: @users.map(&:email).uniq, subject: t("redmire_aspiration")
  end
end
