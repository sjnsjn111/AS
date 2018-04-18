class Teachers::TargetsController < Teachers::TeachersController
  before_action :load_major, only: :create
  before_action :load_target, only: :create

  def index
    @majors = @school.majors.includes(:targets).newest.page(params[:page]).per Settings.per_page
    @year = params[:year] || Date.current.year
  end

  def create
    if @target
      case params[:role]
      when Settings.target_columns.benchmark
        @target.update_attribute :benchmark, params[:value]
      when Settings.target_columns.amount
        @target.update_attribute :amount, params[:value]
      when Settings.target_columns.job
        @target.update_attribute :job, params[:value].to_i.round(4) / 100
      else
        @flash = t "errors_update_target"
      end
    end
  end

  private

  def load_target
    if @major
      @target = @major.targets.find_by(id: params[:target_id])
      return if @target
      @target = @major.targets.create year: params[:year]
    end
  end

  def load_major
    @major = Major.find_by id: params[:major_id]
    return if @major
    @flash = t "not_found_major"
  end
end
