class Teachers::TeachersController < ApplicationController
  layout "teachers/teacher"

  before_action :authenticate_user!
  before_action :load_school
  # before_action :check_permissions_teacher
  # before_action :current_ability
  # load_and_authorize_resource

  private

  def check_permissions_teacher
    return if current_user.is_teacher? @school
    flash[:danger] = t "permission_denied"
    redirect_to root_url
  end
end
