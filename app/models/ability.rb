class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    return undefine_user if user.blank?
    case controller_namespace
    when "Teachers"
      permission_teacher user
    when "Admins"
      permission_admin user
    else
      if user.teacher?
        permission_teacher user
      end

      if user.admin?
        permission_admin user
      end
      permission_user user
    end
  end

  private

  def permission_teacher user
    return unless user.teacher?
    school = user.school
    manage_school user, school
  end

  def manage_school user, school
    can :update, School, id: school.id
    can :manage, Major, school_id: school.id
    can :manage, Target, major_id: school.majors.pluck(:id)
    can %i(update read), User, user_id: school.users.pluck(:id)
  end

  def permission_user user
    can :read, [Major, Department, Note, Notification, Result, Review, School, Subject]
    can :manage, User, id: user.id
    can :manage, Register, user_id: user.id
    can :read, Remarking, result_id: user.results.pluck(:id)
    can :create, Remarking
  end

  def permission_admin user
    return unless user.admin?
    can :manage, :all
  end

  def undefine_user
    cannot :manage, :all
  end
end
