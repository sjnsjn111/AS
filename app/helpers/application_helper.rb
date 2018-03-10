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
end
