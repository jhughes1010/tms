require "SetupTester.rb"

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

    #        [ getter, setter, Target tests ]
    tests = [ [:cp1, :cp1_match_flag=, :cp1_tests],
    [:cp2, :cp2_match_flag=, :cp2_tests],
    [:cp3, :cp3_match_flag=, :cp3_tests] ]
    tests.each { |t| set_flag_for_wafer_sort_operation(t[0], t[1], t[2]) }
  end

  def set_flag_for_wafer_sort_operation(test_program_name, flag, tests)
    targets = Target.find_by_family(self.family)
    setupTester = SetupTester.new(self, targets, test_program_name, tests)
    if setupTester.engineering?
      self.send( flag, 2)
      puts "ENG"
    #elsif setupTester.match?
      #self.send(flag, 3)
    else
      self.send( flag, 1)
      puts "DEFAULT"
    end
  end
end
