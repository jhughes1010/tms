class Setup < ActiveRecord::Base

  #attr_reader :match_cp1, :match_cp2, :match_cp3
  before_save :set_match_flags

  def self.get_setups_magnum(part)
    t = self.where("device in (?) AND platform NOT IN ('EPRO','dualEPRO','quadEPRO')", part).order("device, tab, platform,  location ")
  end

  # model methods supporting business logic
  def test_programs
    [self.cp1, self.cp2, self.cp3]
  end

  def set_match_flags
    self.cp1_match_flag = set_flag_for_wafer_sort_operation(self.cp1, :cp1_match_flag=, :cp1_tests)
    #self.cp2_match_flag = set_flag_for_wafer_sort_operation(self.cp2, :cp2_match_flag=, :cp2_tests)
    #self.cp3_match_flag = set_flag_for_wafer_sort_operation(self.cp3, :cp3_match_flag=, :cp3_tests)
  end

  def set_flag_for_wafer_sort_operation(test_program_name, flag, tests)
    targets = Target.find_by_family(self.family)
    setupTester = SetupTester.new(self, targets, operation, tests)
    if setupTester.engineering?
      self.send(:flag_setter, 2)
    #elsif setupTester.match?
      #self.send(:flag_setter, 3)
    #else
      #self.send(:flag_setter, 2)
    end
  end
end
