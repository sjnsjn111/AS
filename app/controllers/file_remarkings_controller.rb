class FileRemarkingsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  before_action :load_file_remarking_current, :load_note_remarking, only: %i(create index)
  before_action :load_file_remarkings, :load_results, :build_file_remarking, only: :index
  before_action :load_file_remarking, only: :show
  before_action :check_note_remarking, :check_params, :load_schools,  only: :create
  authorize_resource

  include NotesHelper

  def new
    @remarking = @result.remarkings.build
  end

  def create
    return if @error
    FileRemarking.transaction do
      if @file_remarking_current.blank?
        school_id = current_user.registers.first ? current_user.registers.first.school.id : 1
        @file_remarking = current_user.file_remarkings.build school_id: school_id
        @file_remarking.self_attr_after_create params[:content]
        if @file_remarking.save!
          load_file_remarkings
          load_results
          load_file_remarking_current
          @success = t "created_remarking"
        end
      else
        @error = t "exist_remarking"
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    @error = exception.message
  end

  private

  def load_result
    @result = Result.find_by id: params[:result_id]
    @result ||= Result.find_by id: params[:remarking][:result_id] if params[:remarking]
    return if @result
    @error = t "not_found_result"
  end

  def load_schools
    @schools = School.get_newest
  end

  def remarking_params
  params.require(:remarking).permit :content, :school_id, :result_id
  end

  def load_file_remarkings
    @file_remarkings = current_user.file_remarkings.get_newest
  end

  def load_results
    @results = current_user.results.includes(:subject, :remarkings)
  end

  def build_file_remarking
    @file_remarking = current_user.file_remarkings.build
  end

  def load_file_remarking_current
    @file_remarking_current = current_user.file_remarkings.get_current(true)
  end

  def check_params
    return if @error
    count = 0
    params[:content].each do |k,v|
      next if v.blank?
      count += 1
    end
    @error = t "not_remarking_selected" if count == 0
  end

  def load_file_remarking
    @file_remarking = FileRemarking.find_by id: params[:id]
    return if @file_remarking
    @error = t "not_found_file_remarking"
  end

  def load_note_remarking
    @note = Note.remarking.first
    return if @note
    @error = t "not_note_remarking"
  end

  def check_note_remarking
    return if @error || allow_change_in_time?(@note)
    @error = t "not_time_remarking"
  end
end
