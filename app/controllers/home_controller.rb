class HomeController < ApplicationController
  DEST_FOLDER = Rails.root.to_s + "/public"
  def show
  end

  def create
    pdf1 = PDFUploader.new
    pdf1.store! params[:file]
    result = CombinePDF.new
    result << CombinePDF.load(DEST_FOLDER + pdf1.url.to_s)
    result.save DEST_FOLDER + "/#{Time.now.to_i}.pdf"
    send_data result.to_pdf, file_name: "result.pdf", type: "application/pdf"
  end
end
