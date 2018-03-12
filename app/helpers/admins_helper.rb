module AdminsHelper

  def show_level_school level
    case level
    when Settings.university
      Settings.success
    when Settings.college
      Settings.warning
    else Settings.intermediate
      Settings.info
    end
  end

  def get_role user
    case
    when user.teacher?
      Settings.teacher
    when user.student?
      Settings.student
    else
      Settings.admin
    end
  end

  def get_style_note style
    case style
    when Settings.remarking
      Settings.success
    when Settings.aspiration
      Settings.primary
    end
  end
end
