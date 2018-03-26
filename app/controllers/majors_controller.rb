class MajorsController < BaseNotificationsController
  before_action :current_ability
  before_action :load_target, only: :show
  before_action :top_major, :hot_major, only: :index
  load_and_authorize_resource

  def index
    @q = Major.newest.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show; end

  private

  def load_target
    return Settings.default_value unless @major
    @target_now = @major.targets.get_year(Date.today.year).first&.amount
    @target_old = @major.targets.get_year [1.year.ago.year, 2.year.ago.year, 3.year.ago.year]
  end
end
