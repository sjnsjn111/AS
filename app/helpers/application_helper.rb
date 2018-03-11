module ApplicationHelper

  def full_title page_title = ""
    base_title = I18n.t("app")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def resource
    @resource ||= User.new
  end

  def resource_name
    :user
  end

  def get_satus_remarking remarking
    case
    when remarking.pending?
      Settings.warning
    when remarking.rejected?
      Settings.danger
    when remarking.approved?
      Settings.info
    else
      Settings.success
    end
  end

  def get_id_favorite major_id
    current_user.favorites.find_by(major_id: major_id)
  end
end
