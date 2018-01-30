# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(name: "Nguyen Van A", email: "nguyenvana@gmail.com", password: "123456",
#   phone: "01698624222", role: 0, address: "hai chau, Da Nang", phone: "01224558567",
#   sex: 1, people_id: "201697277", nation: "Kinh", nationality: "Việt Nam",
#   birthday: Faker::Date.between(20.years.ago, 19.years.ago))

# 1.upto(4) do |x|
#   name = Faker::Name.name
#   email = "admin#{x}@gmail.com"
#   address = "Hai chau, Da Nang"
#   pass = "123123"
#   pass_conf = "123123"
#   role = 1
#   phone = "#{Faker::Number.number(10)}"
#   sex = Faker::Number.rand(3)
#   people_id = "#{Faker::Number.number(9)}"
#   nation = "kinh"
#   nationality = "Việt Nam"
#   birthday = Faker::Date.between(20.years.ago, 18.years.ago)
#   User.create!(name: name, email: email, password: pass,
#     password_confirmation: pass_conf, role: role, address: address, phone: phone,
#     sex: sex, people_id: people_id, nation: nation, nationality: nationality,
#     birthday: birthday)
# end

# 1.upto(5) do |x|
#   user_id = x
#   school_id = 1
# end

# 1.upto(50) do |x|
#   name = Faker::Name.name
#   email = "user#{x}.@gmail.com"
#   address = "Hai chau, Da Nang"
#   pass = "123123"
#   pass_conf = "123123"
#   role = 0
#   phone = "#{Faker::Number.number(10)}"
#   sex = Faker::Number.rand(3)
#   people_id = "#{Faker::Number.number(9)}"
#   nation = "kinh"
#   nationality = "Việt Nam"
#   birthday = Faker::Date.between(20.years.ago, 18.years.ago)
#   User.create!(name: name, email: email, password: pass,
#     password_confirmation: pass_conf, role: role, address: address, phone: phone,
#     sex: sex, people_id: people_id, nation: nation, nationality: nationality,
#     birthday: birthday)
# end

# School.create!(name: "Đại Học Bách Khoa - Đại Học Đà Nẵng", address: "54 Nguyễn Lương Bằng",
#   phone: "02363 123456", email: "p.daotao.dky@dut.udn.vn", code: "DUT",
#   url_school: "dut.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
#   xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
#   gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
#   mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
#   trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
#   sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
#   level: 0, city: "Đà Nẵng")

School.create!(name: "Đại Học Kinh Tế", address: "54 Ngô Quyền",
  phone: "02363 123456", email: "p.daotao.dky@due.udn.vn", code: "DUE",
  url_school: "due.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
  xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
  gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
  mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
  trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
  sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
  level: 0, city: "Đà Nẵng")

# 1.upto(30) do |x|

#   Department.create!()

# end
