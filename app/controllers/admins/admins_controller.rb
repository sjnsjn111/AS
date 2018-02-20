class Admins::AdminsController < ApplicationController
  layout "admins/admin"

  before_action :authenticate_user!
  # before_action :current_ability
  # load_and_authorize_resource
end
