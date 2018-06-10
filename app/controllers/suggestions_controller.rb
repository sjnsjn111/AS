class SuggestionsController < BaseNotificationsController
  before_action :load_user
  before_action :current_ability
  authorize_resource class: false, through: :users
  before_action :load_major, :load_target, :get_size_register, only: :show

  def show
    calculate = CalculateMarkService.new @major, @target
    @benchmark = (calculate.get_benchmark * 4).round / 4.0
  end

  def index
    @q = Major.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  private

  def load_user
    @users = [current_user.id, params[:user_id]]
  end

  def load_major
    @major = Major.find_by id: params[:id]
    raise ActiveRecord::RecordNotFound if @major.blank?
  end

  def load_target
    return if @major.blank?
    @target = @major.targets.get_year(Time.now.year).first
    raise ActiveRecord::RecordNotFound if @target.blank?
  end

  def get_size_register
    return if @major.blank?
    registers = @major.registers.get_year(Time.now.year)
    @all_register = registers.size
    @aspiration = {}
    @aspiration[t("aspiration_1")] = registers.aspiration_1.size
    @aspiration[t("aspiration_2")] = registers.aspiration_2.size
    @aspiration[t("aspiration_3")] = registers.aspiration_3.size
  end
end
