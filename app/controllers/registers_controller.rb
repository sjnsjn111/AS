class RegistersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  before_action :load_registers, only: %i(index update)
  before_action :load_notes_remarking, :load_major_valid,
    :load_schools, only: :index
  before_action :get_params, only: %i(edit update)
  authorize_resource

  def index
    return if @error.blank?
    flash[:dange] = @error
    redirect_to request.referer || root_url
  end

  def edit
    render partial: "suggestions"
  end

  def update
    Register.transaction do
      @registers.each do |register|
        next if @registers_params[register.aspiration][:major_id] == Settings.default_value
        get_department_best @registers_params[register.aspiration][:major_id]
        register.update_attributes! @registers_params[register.aspiration]
          .merge! department_id: @department_best.first.department_id
      end
      current_user.update_attributes! is_changed_register: true
    end
    render json: {success: true}
  rescue ActiveRecord::RecordInvalid => exception
    render json: {success: false, message: exception.message}
  rescue ActiveRecord::RecordNotUnique => exception
    render json: {success: false, message: exception.message}
  end

  private

  def get_params
    @registers_params = {}
    3.times do |n|
      params["aspiration_#{n + 1}"][:aspiration] = params["aspiration_#{n + 1}"][:aspiration].to_i if params["aspiration_#{n + 1}"]
      params["aspiration_#{n + 1}"][:major_id] = params["aspiration_#{n + 1}"][:major_id].to_i if params["aspiration_#{n + 1}"]
      @registers_params["aspiration_#{n + 1}"] = params.required("aspiration_#{n + 1}").permit!
    end
  end

  def load_registers
    @registers = current_user.registers
  end

  def load_notes_remarking
    @note = Note.aspiration.get_year(DateTime.now.year).first
    return if @note
    @error = t "not_time_change_register"
  end

  def load_schools
    @schools = School.all
  end

  def load_major_valid
    department_ids = current_user.find_user_departments
    major_ids = MajorDepartment.get_by_depart(department_ids).pluck :major_id
    @majors = Major.get_by major_ids
  end

  def get_department_best major_id
    department_ids = MajorDepartment.get_by_major(major_id).pluck :department_id
    @department_best = Result.mark_department_best convert(department_ids), current_user.id
  end

  def convert ids
    str = "("
    ids.each_with_index do |id, i|
      if i != ids.size - 1
        str += "#{id}, "
      else
        str += "#{id})"
      end
    end
    str
  end
end
