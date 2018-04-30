class Teachers::MajorsController < Teachers::TeachersController
  before_action :top_major, :hot_major, only: :index

  def index
    @q = @school.majors.newest.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show; end

  def new; end

  def create
    @major = @school.majors.build major_params
    if @major.save
      @success = t "created_major"
    end
  end

  def edit; end

  def update
    if @major.update_attributes major_params
      @success = t "updated_major"
    end
  end

  def destroy
    if @major.destroy
      @success = t "destroyed_major"
    end
  end

  private

  def major_params
    params.require(:major).permit :name, :code, :picture, :introducing, :style_major_id
  end
end
