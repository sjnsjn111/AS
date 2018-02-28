class Teachers::MajorsController < Teachers::TeachersController
  before_action :load_notifications, only: :index
  before_action :top_major, :hot_major, only: :index
  before_action :load_major, only: :show

  def index
    @q = @school.majors.newest.search params[:q]
    @majors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show; end

  private

  def load_major
    @major = Major.find_by id: params[:id]
    @error = t "not_found_major" unless @major
  end
end
