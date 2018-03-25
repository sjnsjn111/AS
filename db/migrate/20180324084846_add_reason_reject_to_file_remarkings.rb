class AddReasonRejectToFileRemarkings < ActiveRecord::Migration[5.1]
  def change
    add_column :file_remarkings, :reason_reject, :text
  end
end
