class Admins::StyleMajorsController < Admins::AdminsController
  before_action :load_style_major, only: %i(edit update destroy)

  def new
    @style_major = StyleMajor.new
  end

  def index
    @q = StyleMajor.search params[:q]
    @style_majors = @q.result.newest.includes(:majors)
      .page(params[:page]).per Settings.per_page
  end

  def create
    @style_major = StyleMajor.new style_params
    if @style_major.save
      @success = t "created_style_major"
    else
      @error = t "errors_style_major"
    end
  end

  def update
    if @style_major.update_attributes style_params
      @success = t "updated_style_major"
    else
      @error = t "errors_style_major"
    end
  end

  def destroy
    if @style_major.destroy
      @success = t "deleted_style_major"
    else
      @error = t "errors_style_major"
    end
  end

  def edit
    @style_majors = StyleMajor.newest.includes(:majors)
      .page(params[:page]).per Settings.per_page
  end

  private

  def load_style_major
    @style_major = StyleMajor.find_by id: params[:id]
    @error = t "not_found_major" unless @style_major
  end

  def style_params
    params.require(:style_major).permit :name
  end
end
