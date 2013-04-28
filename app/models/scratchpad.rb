class Setup

  def tests
    [self.cp1, self.cp2, self.cp3]
  end

  def set_flags
    set_flag_for_the_operation(self.cp1, :cp1_flag=, :cp1_tests)
    set_flag_for_the_operation(self.cp2, self.cp2_flag, :cp2_tests)
    set_flag_for_the_operation(self.cp3, self.cp3_flag, :cp3_tests)
  end

  def matches_engineering(operation, flag)
    possible = %w(NONE SPTR NOT_ALLOWED CHECK_PCARD)
    if possible.include?(operation)
      flag = 1 # self.send(flag, 1)
      true
    else
      false
    end
  end

  # if flag doesn't work, then pass sym of the variable and set it that way

  def set_flag(operation, flag, tests)
    targets = Target.find_by_family(self.family)
    # Engineering
    return if matches_engineering(operation, flag)

    # highest case - device & tab
    target = targets.select { |t| t.device == self.device && t.tab == self.tab }.first
    if target && target.send(tests).include?(operation)
      flag = 3
      return
    end

    # device test
    target = targets.select { |t| t.device == self.device }.first
    if target && target.send(tests).include?(operation)
      flag = 3
      return
    end

    # default
    target = targets.select { |t| t.device == "default"  }.first
    if target && target.send(tests).include?(operation)
      flag = 3
      return
    end

    flag = 2


  end

end



class Target
  before_save :update_setups

  def cp1_tests
    [self.cp1_mag, self.cp1_mav, self.mag_64]
  end

  def cp2_tests
    [self.cp1_mag, self.cp1_mav, self.mag_64]
  end

  def cp3_tests
    [self.cp1_mag, self.cp1_mav, self.mag_64]
  end


  def update_setups
    setups = Setup.find_by_family(self.family)
    setups.each do |setup|
      setup.set_flags
      setup.save
    end
  end

end



class Hello
  def h=(i)
    @h = i
  end
  def h
    @h
  end
end
