namespace :data do
  desc "Auto generate data"
  task generate_data: :environment do

      Rake::Task["db:migrate:reset"].invoke

    User.create!(name: "Nguyen Van A", email: "nguyenvana@gmail.com", password: "123456",
      phone: "01698624222", role: 0, address: "hai chau, Da Nang", year: DateTime.now.year,
      sex: 1, people_id: "201697277", nation: "Kinh", nationality: "Việt Nam",
      birthday: Faker::Date.between(20.years.ago, 19.years.ago), identification_number: Faker::Code.asin)

    1.upto(5) do |x|
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
        birthday: birthday, religion: religion, school_id: x,
        identification_number: "#{Faker::Code.asin}-#{x}"
    end

    User.create! name: "Admin", email: "admin@gmail.com", password: "123123",
      password_confirmation: "123123", role: 2, address: Faker::Address.street_address,
      phone: "#{Faker::Number.number(10)}",sex: Faker::Number.rand(3), people_id: "#{Faker::Number.number(9)}",
      nation: "kinh", religion: "không", identification_number: Faker::Code.asin, nationality: "Việt Nam",
      birthday: Faker::Date.between(50.years.ago, 40.years.ago), year: DateTime.now.year

    1.upto(150) do |x|
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
      identification_number = "#{Faker::Code.asin}-#{x}"
      religion = "không"
      birthday = Faker::Date.between(20.years.ago, 18.years.ago)
      User.create! name: name, email: email, password: pass, year: DateTime.now.year,
        password_confirmation: pass_conf, role: role, address: address, phone: phone,
        sex: sex, people_id: people_id, nation: nation, nationality: nationality,
        birthday: birthday, identification_number: identification_number, religion: religion
    end

    bkdn = School.create! name: "Đại Học Bách Khoa - Đại Học Đà Nẵng", address: "54 Nguyễn Lương Bằng",
      phone: "02363 123456", email: "p.daotao.dky@dut.udn.vn", code: "DUT",
      url_school: "dut.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
      xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
      gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
      mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
      trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
      sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
      level: 0, city: "Đà Nẵng"

    @ktdn = School.create! name: "Đại Học Kinh Tế - Đại Học Đà Nẵng", address: "54 Ngô Quyền",
      phone: "02363 123456", email: "p.daotao.dky@due.udn.vn", code: "DUE",
      url_school: "due.udn.vn", introducing: "Triết lý giáo dục là tư tưởng chỉ đạo,
      xuyên suốt nhằm hướng đến một mục đích cụ thể trong nền giáo dục của một quốc
      gia, ứng với từng giai đoạn lịch sử. Triết lý giáo dục hướng đến những kỳ vọng,
      mong mỏi của đất nước với mỗi công dân trong việc đóng góp trí tuệ, sức lực,
      trách nhiệm với dân tộc.Trường Đại học Bách khoa với triết lý giáo dục Tư duy,
      sáng tạo, nuôi dưỡng lòng nhân ái đã hướng đến mục tiêu đào tạo ra những con người đầy trí tuệ",
      level: 0, city: "Đà Nẵng"

    nndn = School.create! name: "Đại Học Ngoại Ngữ", address: "254 Nguyễn Văn Linh",
      phone: "(+84) 236.3650403 - (+84) 236.3827111", code: "ULF", url_school: "duytan.edu.vn",
      introducing: "Đào tạo, Nghiên cứu gắn liền với Khoa học và Công nghệ nhằm tạo ra
      những Sinh viên và Học viên có lòng yêu nước, có phẩm chất Nhân văn mang đậm Bản sắc Việt Nam,
      có ý thức sinh hoạt cộng đồng, có sức khỏe, có năng lực và kỹ năng toàn diện,
      tự tin, năng động, sáng tạo và trở thành công dân khởi nghiệp mang tính toàn cầu.",
      level: 0, city: "Đà Nẵng"

    spdn = School.create! name: "Đại Học Sư Phạm", address: "495 Tôn Đức Thắng", phone: "(052)3824052",
      code:"UED", url_school: "quangbinhuni.edu.vn", introducing: "Trường Đại học Sư phạm - Đại học Đà Nẵng
      thực hiện trọng trách đào tạo, bồi dưỡng nguồn nhân lực chất lượng cao và nghiên cứu khoa học, chuyển
      giao công nghệ trên các lĩnh vực khoa học giáo dục, khoa học tự nhiên và công nghệ, khoa học xã hội và
      nhân văn; phục vụ cộng đồng với cam kết đảm bảo chất lượng giáo dục, hội nhập quốc tế.",
      level: 0, city: "Đà Nẵng"

    spktdn = School.create! name: "Đại Học Sư Phạm Kỹ Thuật Đà Nẵng", address: "48 Cao Thắng",
      phone: "02363. 835705/530103", code: "DSK", url_school: "ute.udn.vn",
      introducing: "Đào tạo nguồn nhân lực chất lượng cao; nghiên cứu cơ bản và ứng
      dụng về khoa học tự nhiên, khoa học xã hội - nhân văn và kỹ thuật - công nghệ
      đáp ứng yêu cầu phát triển đất nước.", level: 0, city: "Đà Nẵng"

    StyleMajor.create! name: "Khoa học" #1
    StyleMajor.create! name: "Ngôn ngữ" #2
    StyleMajor.create! name: "Tâm lý học" #3
    StyleMajor.create! name: "Địa lý học" #4
    StyleMajor.create! name: "Báo chí và truyền thông" #5
    StyleMajor.create! name: "Kinh doanh" #6
    StyleMajor.create! name: "Quản trị - Quản lý" #7
    StyleMajor.create! name: "Luật" #8
    StyleMajor.create! name: "Sinh học" #9
    StyleMajor.create! name: "Toán học" #10
    StyleMajor.create! name: "Máy tính" #11
    StyleMajor.create! name: "điện tử" #12
    StyleMajor.create! name: "Xây dựng" #13
    StyleMajor.create! name: "Nông nghiệp" #14
    StyleMajor.create! name: "Lâm nghiệp" #15
    StyleMajor.create! name: "Thủy sản" #16
    StyleMajor.create! name: "Sức khỏe" #17
    StyleMajor.create! name: "Công nhiệp" #18
    StyleMajor.create! name: "Thể dục, thể thao" #19
    StyleMajor.create! name: "Quản lý tài nguyên và môi trường" #20

    bkm1 = Major.create! name: "Công nghệ sinh học", school_id: bkdn.id, code: "A7420201", introducing: "", style_major_id: 9
    bkm2 = Major.create! name: "Công nghệ thông tin", school_id: bkdn.id, code: "A7480201", style_major_id: 11
    bkm3 = Major.create! name: "Công nghệ chế tạo máy", school_id: bkdn.id, code: "A7510202", introducing: "", style_major_id: 12
    bkm4 = Major.create! name: "Công nghệ kỹ thuật vật liệu xây dựng", school_id: bkdn.id, code: "A7510105", introducing: "", style_major_id: 13
    bkm5 = Major.create! name: "Quản lý công nghiệp", school_id: bkdn.id, code: "A7510601", introducing: "", style_major_id: 7
    bkm6 = Major.create! name: "Kỹ thuật cơ khí", school_id: bkdn.id, code: "A7520103", introducing: "", style_major_id: 19
    bkm7 = Major.create! name: "Kỹ thuật cơ điện tử", school_id: bkdn.id, code: "A7520114", introducing: "", style_major_id: 12
    bkm8 = Major.create! name: "Kỹ thuật nhiệt", school_id: bkdn.id, code: "A7520115", introducing: "", style_major_id: 18
    bkm9 = Major.create! name: "Kỹ thuật tàu thủy", school_id: bkdn.id, code: "A7520122", introducing: "", style_major_id: 18
    bkm10 = Major.create! name: "Kỹ thuật điện", school_id: bkdn.id, code: "A7520201", introducing: "", style_major_id: 12
    bkm11 = Major.create! name: "Kỹ thuật điện tử viễn thông", school_id: bkdn.id, code: "A7520207", introducing: "", style_major_id: 12
    bkm12 = Major.create! name: "Kỹ thuật điều khiển  & tự động hóa", school_id: bkdn.id, code: "A7520216", introducing: "", style_major_id: 12
    bkm13 = Major.create! name: "Kỹ thuật hóa học", school_id: bkdn.id, code: "A7520301", introducing: "", style_major_id: 9
    bkm14 = Major.create! name: "Kỹ thuật môi trường", school_id: bkdn.id, code: "A7520320", introducing: "", style_major_id: 20
    bkm15 = Major.create! name: "Công nghệ dầu khí và khai thác dầu", school_id: bkdn.id, code: "A7510701CLC", introducing: "", style_major_id: 18
    bkm16 = Major.create! name: "Công nghệ thực phẩm", school_id: bkdn.id, code: "A7540101", introducing: "", style_major_id: 9
    bkm17 = Major.create! name: "Kiến trúc", school_id: bkdn.id, code: "A7580101CLC", introducing: "", style_major_id: 13
    bkm18 = Major.create! name: "Kinh tế xây dựng", school_id: bkdn.id, code: "A7580201A", introducing: "", style_major_id: 13
    bkm19 = Major.create! name: "Điện tử viễn thông(CTTT)", school_id: bkdn.id, code: "A7505206", introducing: "", style_major_id: 12
    bkm20 = Major.create! name: "Hệ thống nhúng", school_id: bkdn.id, code: "A7905216", introducing: "", style_major_id: 12
    bkm21 = Major.create! name: "Sư phạm kỹ thuật công nghiệp", school_id: bkdn.id, code: "A7140214", introducing: "", style_major_id: 18
    bkm22 = Major.create! name: "Kỹ thuật điện tử & viễn thông (Chất lượng cao)", school_id: bkdn.id, code: "A20207CLC", introducing: "", style_major_id: 12
    bkm23 = Major.create! name: "Kỹ thuật điều khiển & tự động hóa (Chất lượng cao)", school_id: bkdn.id, code: "A220216CLC", introducing: "", style_major_id: 12

    Major.create! name: "Kinh tế", school_id: @ktdn.id, code: "B7310101", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Quản trị kinh doanh", school_id: @ktdn.id, code: "B7340101", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Quản trị Dịch vụ du lịch và lữ hành", school_id: @ktdn.id, code: "B7340103", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Quản trị khách sạn", school_id: @ktdn.id, code: "B7340107", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Marketing", school_id: @ktdn.id, code: "B7340115", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kinh doanh quốc tế", school_id: @ktdn.id,  code: "B7340120", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kinh doanh thương mại", school_id: @ktdn.id, code: "B7340121", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Tài chính - Ngân hàng", school_id: @ktdn.id,  code: "B7340201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kế toán", school_id: @ktdn.id,  code: "B73402112", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kiểm toán", school_id: @ktdn.id,  code: "B7340202", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Quản trị nhân lực", school_id: @ktdn.id, code: "B7340404", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Hệ thống thông tin quản lý", school_id: @ktdn.id, code: "B7340405", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Thống kê kinh tế", school_id: @ktdn.id, code: "B7310107", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Thương mại điện tử", school_id: @ktdn.id, code: "B7340122", introducing: "", style_major_id: rand(1..20)

    Major.create! name: "Sư phạm Tiếng Anh", school_id: nndn.id, code: "D52140201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Sư phạm Tiếng Nga", school_id: nndn.id, code: "D52140202", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Sư phạm Tiếng Pháp", school_id: nndn.id, code: "D52140206", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Sư phạm Tiếng Trung Quốc", school_id: nndn.id, code: "D52140209", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Anh", school_id: nndn.id, code: "D52140211", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Nga", school_id: nndn.id, code: "D52140213", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Pháp", school_id: nndn.id, code: "D52140218", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Trung Quốc", school_id: nndn.id, code: "D52340201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Nhật", school_id: nndn.id, code: "D52340101", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Hàn Quốc", school_id: nndn.id, code: "D52480103", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Ngôn ngữ Thái Lan", school_id: nndn.id, code: "D52480201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Quốc tế học", school_id: nndn.id, code: "D52520201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Tiếng Việt và văn hoá Việt Nam", school_id: nndn.id, code: "D5265464", introducing: "D52620201", style_major_id: rand(1..20)
    Major.create! name: "Đông phương học", school_id: nndn.id, code: "D52850101", introducing: "", style_major_id: rand(1..20)

    sp1 = Major.create! name: "Giáo dục Tiểu học", school_id: spdn.id, code: "N52140202", introducing: "", style_major_id: rand(1..20)
    sp2 = Major.create! name: "Giáo dục Chính trị", school_id: spdn.id, code: "N52140205", introducing: "", style_major_id: rand(1..20)
    sp3 = Major.create! name: "Sư phạm Toán học", school_id: spdn.id, code: "N52140209", introducing: "", style_major_id: rand(1..20)
    sp4 = Major.create! name: "Sư phạm Tin học", school_id: spdn.id, code: "N52140210", introducing: "", style_major_id: rand(1..20)
    sp5 = Major.create! name: "Sư phạm Vật lý", school_id: spdn.id, code: "N52140211", introducing: "", style_major_id: rand(1..20)
    sp6 = Major.create! name: "Sư phạm Hóa học", school_id: spdn.id, code: "N52140212", introducing: "", style_major_id: rand(1..20)
    sp7 = Major.create! name: "Sư phạm Sinh học", school_id: spdn.id, code: "N52140213", introducing: "", style_major_id: rand(1..20)
    sp8 = Major.create! name: "Sư phạm Ngữ văn", school_id: spdn.id, code: "N52140217", introducing: "", style_major_id: rand(1..20)
    sp9 = Major.create! name: "Sư phạm Lịch sử", school_id: spdn.id, code: "N52140218", introducing: "", style_major_id: rand(1..20)
    sp10 = Major.create! name: "Sư phạm Địa lý", school_id: spdn.id, code: "N52140219", introducing: "", style_major_id: rand(1..20)
    sp11 = Major.create! name: "Gíao dục Mầm non", school_id: spdn.id, code: "N52140201", introducing: "", style_major_id: rand(1..20)
    sp12 = Major.create! name: "Sư phạm Âm nhạc", school_id: spdn.id, code: "N52140221", introducing: "", style_major_id: rand(1..20)
    sp13 = Major.create! name: "Việt Nam học", school_id: spdn.id, code: "N52220113", introducing: "", style_major_id: rand(1..20)
    sp14 = Major.create! name: "Lịch sử", school_id: spdn.id, code: "N52220310", introducing: "", style_major_id: rand(1..20)
    sp15 = Major.create! name: "Văn học", school_id: spdn.id, code: "N52220320", introducing: "", style_major_id: rand(1..20)
    sp16 = Major.create! name: "Văn hóa học", school_id: spdn.id, code: "N52220340", introducing: "", style_major_id: rand(1..20)
    sp17 = Major.create! name: "Tâm lý học", school_id: spdn.id, code: "N52310401", introducing: "", style_major_id: rand(1..20)
    sp18 = Major.create! name: "Địa lý học", school_id: spdn.id, code: "N52310501", introducing: "", style_major_id: rand(1..20)
    sp19 = Major.create! name: "Báo chí", school_id: spdn.id, code: "N52320101", introducing: "", style_major_id: rand(1..20)
    sp20 = Major.create! name: "Công nghệ sinh học", school_id: spdn.id, code: "N52420201", introducing: "", style_major_id: rand(1..20)
    sp21 = Major.create! name: "Vật lý học", school_id: spdn.id, code: "N52440102", introducing: "", style_major_id: rand(1..20)
    sp22 = Major.create! name: "Khoa học môi trường", school_id: spdn.id, code: "N52440201", introducing: "", style_major_id: rand(1..20)
    sp23 = Major.create! name: "Toán ứng dụng", school_id: spdn.id, code: "N52460112", introducing: "", style_major_id: rand(1..20)
    sp24 = Major.create! name: "Công nghệ thông tin", school_id: spdn.id, code: "N52480201", introducing: "", style_major_id: rand(1..20)
    sp25 = Major.create! name: "Công tác xã hội", school_id: spdn.id, code: "N52760101", introducing: "", style_major_id: rand(1..20)
    sp26 = Major.create! name: "Quản lý tài nguyên và môi trường", school_id: spdn.id, code: "N52850101", introducing: "", style_major_id: rand(1..20)

    Major.create! name: "Sư phạm Kỹ thuật công nghiệp", school_id: spktdn.id, code: "O7140214", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Sinh học ứng dụng", school_id: spktdn.id, code: "O07140148", introducing: "7420203", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Kỹ thuật giao thông", school_id: spktdn.id, code: "O7510104", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Kỹ thuật Cơ điện tử", school_id: spktdn.id, code: "O7510203", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ kỹ thuật Nhiệt", school_id: spktdn.id, code: "O7510206", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Kỹ thuật Điện tử - Viễn Thông", school_id: spktdn.id, code: "O7510202", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Vật liệu", school_id: spktdn.id, code: "O7510402", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kỹ thuật thực phẩm", school_id: spktdn.id, code: "O7540102", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Kỹ thuật cơ sở hạ tầng", school_id: spktdn.id, code: "O7580210", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Kỹ thuật Ôto", school_id: spktdn.id, code: "O7510205", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Kỹ thuật Điện - Điện tử", school_id: spktdn.id, code: "O7510201", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ kỹ thuật môi trường", school_id: spktdn.id, code: "O7510406", introducing: "", style_major_id: rand(1..20)
    Major.create! name: "Công nghệ Thông tin", school_id: spktdn.id, code: "O7480201", introducing: "", style_major_id: rand(1..20)

    toan = Subject.create! name: "Toán", code: "toan"
    ly = Subject.create! name: "Vật Lý", code: "ly"
    hoa = Subject.create! name: "Hóa Học", code: "hoa"
    sinh = Subject.create! name: "Sinh Học", code: "sinh"
    su = Subject.create! name: "Lịch Sử", code: "su"
    dia = Subject.create! name: "Địa Lý", code: "dia"
    van = Subject.create! name: "Ngữ Văn", code: "van"
    anh = Subject.create! name: "Tiếng Anh", code: "anh"
    nangkhieu = Subject.create! name: "Năng Khiếu", code: "nangkhieu"

    a = Department.create!(name: "A")
    a1 = Department.create!(name: "A1")
    b = Department.create!(name: "B")
    c = Department.create!(name: "C")
    d1 = Department.create!(name: "D1")
    d7 = Department.create!(name: "D7")
    v = Department.create!(name: "V1")

    a.subject_departments.create! subject_id: toan.id
    a.subject_departments.create! subject_id: ly.id
    a.subject_departments.create! subject_id: hoa.id
    a1.subject_departments.create! subject_id: toan.id
    a1.subject_departments.create! subject_id: ly.id
    a1.subject_departments.create! subject_id: anh.id
    b.subject_departments.create! subject_id: toan.id
    b.subject_departments.create! subject_id: hoa.id
    b.subject_departments.create! subject_id: sinh.id
    c.subject_departments.create! subject_id: van.id
    c.subject_departments.create! subject_id: su.id
    c.subject_departments.create! subject_id: dia.id
    d1.subject_departments.create! subject_id: van.id
    d1.subject_departments.create! subject_id: toan.id
    d1.subject_departments.create! subject_id: anh.id
    d7.subject_departments.create! subject_id: hoa.id
    d7.subject_departments.create! subject_id: toan.id
    d7.subject_departments.create! subject_id: anh.id
    v.subject_departments.create! subject_id: nangkhieu.id
    v.subject_departments.create! subject_id: toan.id
    v.subject_departments.create! subject_id: van.id

    [a.id, b.id].each do |id|
      bkm1.major_departments.create! department_id: id
    end
    [a.id, a1.id].each do |id|
      bkm3.major_departments.create! department_id: id
      bkm2.major_departments.create! department_id: id
      bkm4.major_departments.create! department_id: id
      bkm5.major_departments.create! department_id: id
      bkm6.major_departments.create! department_id: id
      bkm7.major_departments.create! department_id: id
      bkm8.major_departments.create! department_id: id
      bkm9.major_departments.create! department_id: id
      bkm10.major_departments.create! department_id: id
      bkm11.major_departments.create! department_id: id
      bkm22.major_departments.create! department_id: id
      bkm12.major_departments.create! department_id: id
      bkm23.major_departments.create! department_id: id
      bkm18.major_departments.create! department_id: id
      bkm19.major_departments.create! department_id: id
      bkm20.major_departments.create! department_id: id
      bkm21.major_departments.create! department_id: id
    end
    [a.id, d7.id].each do |id|
      bkm13.major_departments.create! department_id: id
      bkm14.major_departments.create! department_id: id
      bkm15.major_departments.create! department_id: id
    end
    [a.id, b.id, d7.id].each do |id|
      bkm16.major_departments.create! department_id: id
      bkm16.major_departments.create! department_id: id
      bkm16.major_departments.create! department_id: id
      bkm16.major_departments.create! department_id: id
    end
    [v.id].each do |id|
      bkm17.major_departments.create! department_id: id
    end
    [a.id, a1.id, d1.id].each do |id|
      @ktdn.majors.each do |major|
        major.major_departments.create! department_id: id
      end
    end

    [d1.id].each do |id|
      sp1.major_departments.create! department_id: id
    end
    sp2.major_departments.create! department_id: c.id
    [a.id, a1.id].each do|id|
      sp3.major_departments.create! department_id: id
      sp4.major_departments.create! department_id: id
      sp5.major_departments.create! department_id: id
      sp21.major_departments.create! department_id: id
      sp23.major_departments.create! department_id: id
      sp24.major_departments.create! department_id: id
    end
    [a.id, b.id].each do |id|
      sp6.major_departments.create! department_id: id
      sp16.major_departments.create! department_id: id
      sp19.major_departments.create! department_id: id
      sp22.major_departments.create! department_id: id
    end
    sp7.major_departments.create! department_id: b.id
    [c.id, d1.id].each do |id|
      sp8.major_departments.create! department_id: id
      sp9.major_departments.create! department_id: id
      sp10.major_departments.create! department_id: id
      sp11.major_departments.create! department_id: id
      sp13.major_departments.create! department_id: id
      sp14.major_departments.create! department_id: id
      sp15.major_departments.create! department_id: id
      sp17.major_departments.create! department_id: id
      sp18.major_departments.create! department_id: id
      sp19.major_departments.create! department_id: id
      sp25.major_departments.create! department_id: id
    end
    sp26.major_departments.create! department_id: b.id

    User.student.each do |s|
      array = [toan.id, van.id, anh.id]
      array.each do |n|
        s.results.create! subject_id: n, mark: Faker::Number.rand(1.0..10.0).round(1)
      end
      array1 = [hoa.id, dia.id]
      array2 = [ly.id, su.id]
      array3 = [anh.id, sinh.id, nangkhieu.id]
      s.results.create! subject_id: array1.sample, mark: Faker::Number.rand(1.0..10.0).round(1)
      s.results.create! subject_id: array2.sample, mark: Faker::Number.rand(1.0..10.0).round(1)
      s.results.create! subject_id: array3.sample, mark: Faker::Number.rand(1.0..10.0).round(1)
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
      major_ids.each_with_index do |major_id, index|
        department_major_ids = MajorDepartment.get_by_major(major_id).pluck :department_id
        department_id = (department_ids&department_major_ids).first
        major_ids.delete major_id
        u.registers.create! major_id: major_id, department_id: department_id, aspiration: index if index < 3
      end
    end

    Note.create! start_time: 10.days.ago, end_time: 1.months.from_now, style: 0

    Note.create! start_time: 5.days.ago, end_time: 2.months.from_now, style: 1

    User.student.limit(20).each do |user|
      school_id = user.registers.first ? user.registers.first.school.id : 1
      file_remarking = user.file_remarkings.build school_id: school_id
      remarkings_ids = {"#{user.results.first.id}" => Faker::Lorem.sentence(50),
        "#{user.results.second.id}" => Faker::Lorem.sentence(50)}
      file_remarking.self_attr_after_create remarkings_ids
      file_remarking.save!
    end
  end
end
