class Device < ActiveRecord::Base
  def self.get_family( family)
    self.where("productline = ?", family).order("name")
  end
end
