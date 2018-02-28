class Teachers::UsersController < Teachers::TeachersController
  before_action :load_notifications, only: :index

  def index; end
end
