class RedmireNote
  def initialize
    @users_not_change = list_users_not_change_register
    @users_not_remarking = list_users_not_remaking
  end

  def list_users_not_change_register
    User.get_year(Time.now.year).student.change_aspiration false
  end

  def list_users_not_remaking
    remarked_user_ids = FileRemarking.get_year(Time.now.year).includes(:user).map &:user_id
    User.student.get_not_id remarked_user_ids
  end

  def near_expires_remarking?
    note_remarking = Note.get_year(Time.now.year).remarking.first
    Time.zone.local_to_utc(Time.now).between?(note_remarking.end_time - 1.day, note_remarking.end_time)
  end

  def near_expires_change_aspiration?
    note_change = Note.get_year(Time.now.year).aspiration.first
    Time.zone.local_to_utc(Time.now).between?(note_change.end_time - 1.day, note_change.end_time)
  end

  def send_mail_redmire
    RedmireNoteMailer.redmire_remarking(@users_not_remarking.limit(20)).deliver_now if near_expires_remarking?
    RedmireNoteMailer.redmire_aspiration(@users_not_change.limit(20)).deliver_now if near_expires_change_aspiration?
  end
end
