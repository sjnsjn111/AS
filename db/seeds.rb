# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Nguyen Van A", email: "nguyenvana@gmail.com", password: "123456",
  phone: "01698624222", role: 0, address: "hai chau, Da Nang", year: DateTime.now.year,
  sex: 1, people_id: "201697277", nation: "Kinh", nationality: "Việt Nam",
  birthday: Faker::Date.between(20.years.ago, 19.years.ago), identification_number: Faker::Code.asin)

1.upto(4) do |x|
  name = Faker::Name.name
  email = "teacher#{x}@gmail.com"
  address = Faker::Address.street_address
  pass = "123123"
  pass_conf = "123123"
  role = 1
  phone = Faker::PhoneNumber.cell_phone
  sex = Faker::Number.rand(3)
  people_id = "#{Faker::Number.number(9)}"
  religion = "không"
  nation = "kinh"
  nationality = "Việt Nam"
  birthday = Faker::Date.between(30.years.ago, 20.years.ago)
  User.create! name: name, email: email, password: pass, year: DateTime.now.year,
    password_confirmation: pass_conf, role: role, address: address, phone: phone,
    sex: sex, people_id: people_id, nation: nation, nationality: nationality,
    birthday: birthday, religion: religion, school_id: rand(1..2),
    identification_number: Faker::Code.asin
end

User.create! name: Faker::Name.name, email: "admin@gmail.com", password: "123123",
  password_confirmation: "123123", role: 2, address: Faker::Address.street_address,
  phone: "#{Faker::Number.number(10)}", sex: Faker::Number.rand(3), people_id: "#{Faker::Number.number(9)}",
  nation: "kinh", religion: "không", identification_number: Faker::Code.asin, nationality: "Việt Nam",
  birthday: Faker::Date.between(50.years.ago, 40.years.ago), year: DateTime.now.year

1.upto(100) do |x|
  name = Faker::Name.name
  email = "user#{x}@gmail.com"
  address = "Hai chau, Da Nang"
  pass = "123123"
  pass_conf = "123123"
  role = 0
  phone = Faker::PhoneNumber.cell_phone
  sex = Faker::Number.rand(3)
  people_id = "#{Faker::Number.number(9)}"
  nation = "kinh"
  nationality = "Việt Nam"
  identification_number = Faker::Code.asin
  religion = "không"
  birthday = Faker::Date.between(20.years.ago, 18.years.ago)
  User.create! name: name, email: email, password: pass, year: DateTime.now.year,
    password_confirmation: pass_conf, role: role, address: address, phone: phone,
    sex: sex, people_id: people_id, nation: nation, nationality: nationality,
    birthday: birthday, identification_number: identification_number, religion: religion
end

School.create! name: "Đại Học Bách Khoa - Đại Học Đà Nẵng", address: "54 Nguyễn Lương Bằng",
  phone: "02363 123456", email: "p.daotao.dky@dut.udn.vn", code: "DUT",
  url_school: "dut.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
  xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
  gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
  mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
  trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
  sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
  level: 0, city: "Đà Nẵng"

School.create! name: "Đại Học Kinh Tế", address: "54 Ngô Quyền",
  phone: "02363 123456", email: "p.daotao.dky@due.udn.vn", code: "DUE",
  url_school: "due.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
  xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
  gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
  mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
  trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
  sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
  level: 0, city: "Đà Nẵng"

1.upto(20) do |school|
  StyleMajor.create! name: Faker::Job.field
end

1.upto(10) do |x|
  name = Faker::Name.initials(2)
  school_id = [1]
  Department.create!(name: name, school_id: school_id)
end

1.upto(10) do |x|
  name = Faker::Name.initials(2)
  school_id = [1, 2]
  Department.create!(name: name, school_id: school_id)
end

1.upto(10) do |x|
  name = Faker::Name.initials(2)
  school_id = [2]
  Department.create!(name: name, school_id: school_id)
end

1.upto(20) do |x|
  Major.create! school_id: 1, name: Faker::Name.name, code: "#{Faker::Code.asin}-#{x*2}",
    introducing: Faker::Lorem.sentence(50), style_major_id: rand(1..20)
end

1.upto(20) do |x|
  Major.create! school_id: 2, name: Faker::Name.name, code: "#{Faker::Code.asin}-#{x*3}",
    introducing: Faker::Lorem.sentence(50), style_major_id: rand(1..20)
end

1.upto(8) do |x|
  Subject.create! name: Faker::Ancient.titan, code: Faker::Code.asin
end

Department.all.each do |d|
  array = (1..8).to_a
  1.upto(3)do |n|
    b = array.sample
    array.delete b
    d.subject_departments.create! subject_id: b
  end
end

Major.all.each do |m|
  array = (1..20).to_a
  1.upto(3)do |n|
    b = array.sample
    array.delete b
    m.major_departments.create! department_id: b
  end
end

User.student.each do |s|
  array = (1..8).to_a
  1.upto(6) do |n|
    b = array.sample
    array.delete b
    s.results.create! subject_id: b, mark: Faker::Number.rand(1.0..10.0).round(1)
  end
end

Major.all.each do |m|
  m.targets.create! amount: Faker::Number.rand(50..100), year: 2016, benchmark: Faker::Number.rand(15..30)
  m.targets.create! amount: Faker::Number.rand(50..100), year: 2017, benchmark: Faker::Number.rand(15..30)
  m.targets.create! amount: Faker::Number.rand(50..100), year: 2018
  m.reviews.create! amount: Faker::Number.rand(40.0..100.0).round(2)
end

User.student.each do |u|
  department_ids = u.find_user_departments
  major_ids = MajorDepartment.get_by_depart(department_ids).pluck :major_id
  department_ids.each_with_index do |department_id, index|
    major_id = major_ids.sample
    # major = Major.find_by id: b
    # department_major_ids = major.departments.pluck(:id)
    # major_id = department_major_ids.sample
    major_ids.delete major_id
    u.registers.create! major_id: major_id, department_id: department_id, aspiration: index if index < 3
  end
end

Note.create! start_time: 10.days.ago, end_time: 1.months.from_now, style: 0

Note.create! start_time: 5.days.ago, end_time: 2.months.from_now, style: 1

User.student.limit(50).each do |user|
  school_id = user.registers.first ? user.registers.first.school.id : 1
  file_remarking = user.file_remarkings.build school_id: school_id
  remarkings_ids = {"#{user.results.first.id}" => Faker::Lorem.sentence(50),
    "#{user.results.second.id}" => Faker::Lorem.sentence(50)}
  file_remarking.self_attr_after_create remarkings_ids
  file_remarking.save!
end
