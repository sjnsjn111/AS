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

  def option_major_for_select majors, register
    majors.map do |major|
      [major.name, major.id, class: "option-major-#{register.id}-#{major.school_id}"]
    end
  end

  def option_school_for_select schools
    schools.map do |school|
      [school.name, school.id]
    end
  end

  def get_major_registed_id registers
    registers.map do |register|
      register.major_id
    end
  end

  def get_mark_register register
    subject_ids = register.department.subjects.pluck :id
    mark = current_user.results.get_by_subject(subject_ids).sum :mark
    mark
  end
end
