class PdfService
  def initialize file_remarking
    @file_remarking = file_remarking
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: Settings.a4)
    kit.to_file "#{Rails.root}/public/file_remarking"
  end

  def filename
    "FileRemarking#{file_remarking.id}.pdf"
  end
end
