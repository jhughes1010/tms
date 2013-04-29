class SetupTester
  def initialize(setup, targets, test_program_name, tests)
    @setup = setup
    @targets = targets
    @test_program_name = test_program_name
    @tests = tests
  end

  def engineering?
    possible = %w(NONE SPTR NOT_ALLOWED CHECK_PCARD)
    possible.include?(@test_program_name)
    puts @test_program_name
    #puts possible
  end

  def match?
    device_and_tab? || device? || default?
  end

  def device_and_tab?
    target = @targets.select { |t| t.device == @setup.device && t.tab == @setup.tab }.first
    target && target.send(@tests).include?(@operation)
  end

  def device?
    target = @targets.select { |t| t.device == @setup.device }.first
    target && target.send(@tests).include?(@operation)
  end

  def default?
    target = @targets.select { |t| t.device == "default"  }.first
    target && target.send(@tests).include?(@operation)
  end
end
