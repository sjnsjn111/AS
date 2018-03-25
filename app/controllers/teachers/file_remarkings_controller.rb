class Teachers::FileRemarkingsController < Teachers::TeachersController
  before_action :get_size_status, :load_notifications,
    :get_file_remarkings, only: :index
  before_action :load_file_remarking, only: %i(edit update destroy)

  def edit
    return if @error
    @remarkings = @file_remarking.remarkings
  end

  def update
    return if @error
    if params[:file_remarking] && params[:file_remarking][:status] == "rejected"
      reject_file_remarking
    else
      params_permit = params.require(:file_remarking).permit results: [:id, :mark]
      if params_permit.present? && params[:change_register] == Settings.string_true
        update_with_changed_result params_permit
      end
      if @file_remarking.update_attributes file_remarking_params
        get_size_status
        get_file_remarkings
        @success = t "updated_remarking"
      end
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
    params.require(:file_remarking).permit :status, :is_current
  end

  def update_with_changed_result params_permit
    results_ids = params_permit[:results].keys
    marks = params_permit[:results].values.pluck :mark
    @file_remarking.self_attr_after_update results_ids, marks
    @file_remarking.is_changed = true
  end

  def reject_file_remarking
    params_permit = params.require(:file_remarking).permit(:status, :is_current, :reason_reject)
    if @file_remarking.update_attributes params_permit
      get_size_status
      get_file_remarkings
      @success = t "reject_remarking"
    end
  end
end
