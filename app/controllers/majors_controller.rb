class MajorsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  before_action :load_major, :load_target, only: :show
  before_action :load_top, only: :index
  authorize_resource

  def index
    @q = Major.newest.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show; end

  private

  def load_major
    @major = Major.find_by id: params[:id]
    @error = t "not_found_major" unless @major
  end

  def load_target
    return Settings.default_value unless @major
    @target_now = @major.targets.get_year(Date.today.year).first.amount
    @target_old = @major.targets.get_year [1.year.ago.year, 2.year.ago.year, 3.year.ago.year]
  end

  def load_top
    @top_target = Target.top_mark(1.year.ago.year).first
  end
end
