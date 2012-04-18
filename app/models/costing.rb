class Costing < ActiveRecord::Base
  attr_accessor :untested_die_cost, :untested_die_cost_percentage, :die_sort_cost, :die_sort_cost_percentage, :die_assembly_cost, :die_assembly_cost_percentage, :die_ft_cost, :die_ft_cost_percentage, :die_backend_cost, :die_backend_cost_percentage, :die_overhead_cost, :die_overhead_cost_percentage, :total_cost

  def self.search(params)
    results = scoped
    results = results.where("device like ?", "%" + params[:device] + "%") if params[:device]
    results = results.where("device like ?", "%" + params[:tab] + "%") if params[:tab]
    results = results.where("pc like ?", "%" + params[:pc] + "%") if params[:pc]
    results = results.order("device")
    results
  end

  def self.scope_builder
    DynamicDelegator.new(scoped)
  end

  def untested_die_cost
    self.wafercost/self.netgooddie
  end
  def untested_die_cost_percentage
    self.untested_die_cost/self.total_cost
  end
  def die_sort_cost
    self.diecost - self.untested_die_cost
  end
  def die_sort_cost_percentage
    self.die_sort_cost/self.total_cost
  end
  def die_assembly_cost
    self.asm_cost - self.diecost
  end
  def die_assembly_cost_percentage
    self.asm_cost - self.diecost
  end
  def die_ft_cost
    self.tst_cost - self.asm_cost
  end
  def die_ft_cost_percentage
    self.tst_cost - self.asm_cost
  end
  def die_backend_cost
    self.fg_subcon
  end
  def die_backend_cost_percentage
    self.fg_subcon
  end
  def die_overhead_cost
    self.tst_ohcost + self.asm_ohcost
  end
  def die_overhead_cost_percentage
    self.tst_ohcost + self.asm_ohcost
  end
  def total_cost
    self.fg_stdcost
  end
end