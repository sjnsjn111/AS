class Teachers::RemarkingsController < Teachers::TeachersController

  def index
    @remarkings = Support::ReamrkingSupport.new @page, @school
  end
end
