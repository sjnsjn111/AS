class Admins::SchoolsController < Admins::AdminsController
  before_action :load_statistic_school, only: :index
  before_action :load_school, except: %i(new create index)

  def index
    @schools = School.get_newest.page(params[:page]).per Settings.per_page
  end

  def new
    @school = School.new
  end

  def create
    return if @error
    @school = School.new school_params
    if @school.save
      @success = t "created_school"
    end
  end

  def update
    return if @error
    if @school.update_attributes school_params
      @success = t "updated_school"
    end
  end

  def destroy
    return if @error
    if @school.destroy
      @success = t "destroyed_school"
    end
  end

  private

  def load_statistic_school
    @top = Target.top_school(1.years.ago.year).first
    @hot = Register.hot_school(Time.now.year).first
    @total = School.all.size
  end

  def load_school
    @school = School.find_by id: params[:id]
    return if @school
    @error = t "not_found_school"
  end

  def school_params
    params.require(:school).permit :name, :address, :phone, :email, :code,
      :logo, :url_school, :introducing, :level, :city
  end
end
