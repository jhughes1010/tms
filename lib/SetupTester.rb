#require "Target.rb"

class SetupTester
  def initialize(setup, targets, test_program_name, tests)
    @setup = setup
    @targets = targets
    @test_program_name = @setup.send(test_program_name)
    @tests = tests
  end

  def engineering?
    possible = %w(NONE SPTR NOT_ALLOWED CHECK_PCARD)
    possible.include?(@test_program_name)
  end

  def match?
    #current approach
    #device_and_tab? || device? || default?
    #thinking about this
    #the special program cases need to be processed in a hierarchical order and
    #if a targets table entry exists, then no other case can be considered for compare
    if device_and_tab_match_exists?
      device_and_tab?
    elsif device_and_tab_wildcard_exists?
      device_and_tab_wildcard?
    elsif device_match_exists?
      device?
    elsif default_match_exists?
      default?
    end
  end

  def device_and_tab_match_exists?
    target = @targets.select { |t| t.device == @setup.device && t.tab == @setup.tab }.first
  end

  def device_and_tab_wildcard_exists?
    target = @targets.select { |t|
      match_device = %r(^#{t.device.gsub("_",".")}$).match(@setup.device).to_s
      match_tab = %r(^#{t.tab.gsub("_",".")}$).match(@setup.tab).to_s
      match_device == @setup.device && match_tab == @setup.tab
    }.first
  end

  def device_match_exists?
    target = @targets.select { |t| t.device == @setup.device && t.tab == "all" }.first
  end

  def default_match_exists?
    target = @targets.select { |t| t.device == "default"  }.first
  end

  def device_and_tab?
    target = @targets.select { |t| t.device == @setup.device && t.tab == @setup.tab }.first
    target && target.send(@tests).include?(@test_program_name)
  end

  def device_and_tab_wildcard?
    target = @targets.select { |t|
      match_device = %r(^#{t.device.gsub("_",".")}$).match(@setup.device).to_s
      match_tab = %r(^#{t.tab.gsub("_",".")}$).match(@setup.tab).to_s
      match_device == @setup.device && match_tab == @setup.tab
    }.first
    target && target.send(@tests).include?(@test_program_name)
  end

  def device?
    target = @targets.select { |t| t.device == @setup.device }.first
    target && target.send(@tests).include?(@test_program_name)
  end

  def default?
    target = @targets.select { |t| t.device == "default"  }.first
    target && target.send(@tests).include?(@test_program_name)
  end
end
