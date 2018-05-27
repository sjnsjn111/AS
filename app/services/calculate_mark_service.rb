class CalculateMarkService
  def initialize major, target
    @major = major
    @target = target
  end

  def get_benchmark
    registers_success = Register.get_register_success(@target.amount, @major.id, :aspiration_1)
    bench_mark_asp_1 = registers_success.last&.mark
    success_ids = registers_success.pluck :id #1

    #check aspration 2
    asp_2_bigger_than_asp_1 = Register.get_register_success(@target.amount, @major.id,
      %i(aspiration_1 aspiration_2)).aspiration_2
    registers_2_fail_asp_1 = get_fail_aspiration_1 asp_2_bigger_than_asp_1 #2
    registers_success = get_registers_success success_ids, registers_2_fail_asp_1, @target.amount
    bench_mark_asp_1_2 = registers_success.last&.mark
    success_ids = registers_success.pluck :id

    #check aspiration 3
    asp_3_bigger_than_asp_1_2 = Register.get_register_success(@target.amount, @major.id,
      %i(aspiration_1 aspiration_2 aspiration_3)).aspiration_3
    registers_3_fail_asp_1 = get_fail_aspiration_1 asp_3_bigger_than_asp_1_2

    if registers_3_fail_asp_1.blank?
      return bench_mark_asp_1_2 ? bench_mark_asp_1_2 : bench_mark_asp_1
    end
    get_register_fails_temp = Register.get_by_id registers_3_fail_asp_1

    register_3_fail_asp_2 = [] #3
    get_register_fails_temp.each do |register|
      register_2 = Register.get_year(Time.new.year).get_by_user(register.user_id)
        .aspiration_2.first
      major = register_2.major
      target = major.targets.get_year(Time.now.year).first
      asp_1_success = Register.get_register_success(target.amount, major.id, :aspiration_1).pluck :id
      asp_2_bigger_than_asp_1 = Register.get_register_success(target.amount, major.id,
        %i(aspiration_1 aspiration_2)).aspiration_2
      registers_2_fail_asp_1 = get_fail_aspiration_1 asp_2_bigger_than_asp_1
      next if registers_2_fail_asp_1.blank?
      registers_success = get_registers_success asp_1_success, registers_2_fail_asp_1, target.amount
      registers_success_ids = registers_success.pluck :id
      register_3_fail_asp_2 << register.id unless registers_success_ids.include? register_2.id
    end

    return bench_mark_asp_1_2 if register_3_fail_asp_2.blank?
    registers_success = get_registers_success success_ids, register_3_fail_asp_2, @target.amount
    bench_mark_asp_1_2_3 = registers_success.last&.mark
    bench_mark_asp_1_2_3
  end

  def get_fail_aspiration_1 registers
    return if registers.blank?
    registers_fail = []
    registers.each do |register|
      register_1 = Register.get_year(Time.new.year).get_by_user(register.user_id)
        .aspiration_1.first
      major = register_1.major
      target = major.targets.get_year(Time.now.year).first
      bench_mark_temp = Register.get_register_success(target.amount, major.id,
        :aspiration_1).last&.mark
      registers_fail << register.id if register_1.mark < bench_mark_temp
    end
    registers_fail
  end

  def get_registers_success success_ids, registers_fail_asp, amount
    success_ids = success_ids | registers_fail_asp.to_a
    registers_new = Register.get_by_id success_ids
    registers_new.get_success_no_major amount
  end

end
