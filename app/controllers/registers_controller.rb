class RegistersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  authorize_resource

  def index

  end
end
