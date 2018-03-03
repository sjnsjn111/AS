class RemarkingsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  before_action :load_result, :load_schools, only: :new
  before_action :load_remarkings, :load_results, only: :index
  before_action :load_remarking, only: :show
  load_and_authorize_resource

  def new
    @remarking = @result.remarkings.build
  end

  def create
    @remarking = Remarking.new remarking_params
    @remarking.status = :pending
    if @remarking.save
      load_remarkings
      @success = t "created_remarking"
    else
      load_result
      load_schools
    end
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

  def load_remarkings
    @remarkings = current_user.remarkings.includes(:subject)
      .includes(:user).includes(:school).get_newest
  end

  def load_results
    @results = current_user.results.includes(:subject).includes(:remarkings)
  end

  def load_remarking
    @remarking = Remarking.find_by id: params[:id]
    return if @remarking
    @error = t "not_found_remarking"
  end
end
