class Admins::NotesController < Admins::AdminsController
  before_action :load_notifications, only: :index
  before_action :build_note, only: :new
  before_action :load_note, only: %i(edit update destroy)

  def index
    @notes = Note.get_year(DateTime.now.year).notes_lastest
  end

  def create
    return if @error
    @note = Note.new note_params
    if @note.save
      @success = t "created_note"
    end
  end

  def update
    return if @error
    if @note.update_attributes note_params
      @success = t "updated_note"
    end
  end

  def destroy
    return if @error
    if @note.destroy
      @success = t "destroyed_note"
    end
  end

  private

  def load_note
    @note = Note.find_by id: params[:id]
    return if @note
    @error = t "not_found_note"
  end

  def note_params
    params[:note][:style] = params[:note][:style].to_i if params[:note]
    params.require(:note).permit :start_time, :end_time, :style
  end

  def build_note
    @note = Note.new
  end
end
