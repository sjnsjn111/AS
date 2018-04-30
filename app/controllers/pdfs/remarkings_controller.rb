class Pdfs::RemarkingsController < ApplicationController
  before_action :load_file_remarkings, only: :index
  layout "pdf/remarking_pdf"

  def index
    respond_to do |format|
      format.pdf {send_remarking_pdf}
      format.html
    end
  end

  private

  def load_file_remarkings
    @file_remarkings = FileRemarking.get_year(Time.new.year).approved
      .includes :user, :remarkings, :subjects, :results
  end

  def create_remarking_pdf
    PdfService.new @file_remarkings
  end

  def send_remarking_pdf
    send_file create_remarking_pdf.to_pdf,
      filename: create_remarking_pdf.filename,
      type: "application/pdf",
      disposition: "inline"
  end
end
