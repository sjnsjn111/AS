require "redmire_note"

namespace :redmire do
  desc "Auto redmire notes"
  task notes: :environment do
    RedmireNote.new.send_mail_redmire
  end
end
