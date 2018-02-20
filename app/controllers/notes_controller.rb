class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  authorize_resource

  def index
    @notes = Note.get_year(DateTime.now.year).notes_lastest
    @note_cal = Note.notes_lastest.group_by &:style
  end
end
