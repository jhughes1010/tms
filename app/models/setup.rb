class Setup < ActiveRecord::Base

  attr_reader :match_cp1, :match_cp2, :match_cp3

  def self.get_setups_magnum(part)

    t = self.where("device in (?) AND platform NOT IN ('EPRO','dualEPRO','quadEPRO')", part).order("device, tab, platform,  location ")
    #t = self.where("device in (?)", part).order("device, platform , tab,  location ")
  end

  # model methods supporting business logic
  def test_programs
    [self.cp1, self.cp2, self.cp3]
  end

  def set_flags
    set_flag_for_wafer_sort_operation(self.cp1, self.cp1_flag, :cp1_tests)
    set_flag_for_wafer_sort_operation(self.cp2, self.cp2_flag, :cp2_tests)
    set_flag_for_wafer_sort_operation(self.cp3, self.cp3_flag, :cp3_tests)
  end

  def set_flag_for_wafer_sort_operation(operation, flag, tests)
    targets = Target.find_by_family(self.family)
    # Engineering
    return if matches_engineering(operation, flag)
    return if matches_device_tab(operation, flag)
    return if matches_device(operation, flag)
    return if matches_default(operation, flag)
    flag = 2 #mismatch
  end

end
