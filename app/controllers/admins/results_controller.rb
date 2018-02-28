class Admins::ResultsController < Admins::AdminsController
  before_action :load_notifications, only: :index

  def index
    @results = Result.get_year(DateTime.now.year).get_newest
      .includes(:user).group_by &:user_id
  end
end
