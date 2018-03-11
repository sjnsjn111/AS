class DownloadsController < ApplicationController
  before_action :load_file_remarking, only: :show
  layout "pdf/remarking_pdf"

  def show
    respond_to do |format|
      format.pdf {send_remarking_pdf}
      format.html
    end
  end

  private

  def load_file_remarking
    @file_remarking = FileRemarking.find_by id: params[:file_remarking_id]
    if @file_remarking.blank?
      flash[:danger] = t "not_found_file_remarking"
      redirect_to request.referer || root_path
    end
  end

  def create_remarking_pdf
    PdfService.new file_remarking
  end

  def send_remarking_pdf
    send_file create_remarking_pdf.to_pdf,
      filename: file_remarking_pdf.filename,
      type: "application/pdf",
      disposition: "inline"
  end
end
