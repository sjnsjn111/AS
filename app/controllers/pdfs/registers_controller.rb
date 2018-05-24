class Pdfs::RegistersController < ApplicationController
  before_action :load_school, only: :index
  layout "pdf/remarking_pdf"

  def index
    respond_to do |format|
      format.html
    end
  end

  private
  def load_school
    @schools = School.all
  end
end
