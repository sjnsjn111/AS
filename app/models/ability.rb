class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    return undefine_user if user.blank?
    case controller_namespace
    when "teachers"
      permission_teacher user
    else
      if user.teacher?
        permission_teacher user
      end

      if user.admin?
        permission_admin
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

  def permission_user user
    can :read, :all
    can :update, User, id: user.id
    can :manage, Register, user_id: user.id
    can :manage, Remarking, user_id: user.id
  end

  def permission_admin
    can :manage, :all
  end

  def undefine_user
    cannot :manage, :all
  end
end
