class SuggestionsController < BaseNotificationsController
  before_action :load_user
  before_action :current_ability
  authorize_resource class: false, through: :users

  def index
    @q = Major.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def load_user
    @users = [current_user.id, params[:user_id]]
  end
end
