class StaticPagesController < BaseNotificationsController
  def index
    @q = User.search params[:q]
    if request.xhr?
      @users = @q.result.includes(:subjects, :results).student
        .user_newest.page(params[:page]).per Settings.per_page
    end
  end
end
