class Admins::AdminsController < BaseNotificationsController
  layout "admins/admin"

  before_action :current_ability
  authorize_resource
end
