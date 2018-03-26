class NotesController < BaseNotificationsController
  before_action :current_ability
  authorize_resource

  def index
    @notes = Note.get_year(DateTime.now.year).notes_lastest
  end
end
