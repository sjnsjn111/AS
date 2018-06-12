namespace :data do
  desc "Auto delete data"
  task delete_data_test: :environment do
    User.student.order(id: :desc).limit(11).each do |u|
      u.really_destroy!
    end
  end
end
