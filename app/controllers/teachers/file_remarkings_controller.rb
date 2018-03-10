class Teachers::FileRemarkingsController < Teachers::TeachersController
  before_action :get_size_status, :load_notifications,
    :get_file_remarkings, only: :index
  before_action :load_file_remarking, only: %i(update destroy)

  def update
    return if @error
    if @file_remarking.update_attributes file_remarking_params
      get_size_status
      get_file_remarkings
      @success = t "updated_remarking"
    end
  end

  private

  def get_size_status
    @statuses = @school.file_remarkings.size_status
  end

  def get_file_remarkings
    @role = params[:role]
    if @role.present?
      @q = @school.file_remarkings.send(@role).search params[:q]
    else
      @q = @school.file_remarkings.search params[:q]
    end
    @file_remarkings = @q.result.get_lastest
      .page(params[:page]).per Settings.per_page
  end

  def load_file_remarking
    @file_remarking = FileRemarking.find_by id: params[:id]
    return if @file_remarking
    @error = t "not_found_file_remarking"
  end

  def file_remarking_params
    params.permit :status, :is_current
  end
end
