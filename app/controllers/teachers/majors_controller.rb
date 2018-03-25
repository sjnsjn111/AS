class Teachers::MajorsController < Teachers::TeachersController
  before_action :top_major, :hot_major, only: :index
  before_action :load_major, only: %i(show edit update)

  def index
    @q = @school.majors.newest.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show; end

  def create
    @major = @school.majors.build major_params
    if @major.save
      @success = t "created_major"
    end
  end

  def update
    if @major.update_attributes major_params
      @success = t "updated_major"
    end
  end

  private

  def load_major
    @major = Major.find_by id: params[:id]
    @error = t "not_found_major" unless @major
  end

  def major_params
    params.require(:major).permit :name, :code, :picture, :introducing, :style_major_id
  end
end
