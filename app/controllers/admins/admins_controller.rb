class Admins::AdminsController < BaseNotificationsController
  layout "admins/admin"

  before_action :current_ability
  authorize_resource

  def load_user_registers
    return if @user.blank?
    @registers = @user.registers.aspiration_increase
  end
end
