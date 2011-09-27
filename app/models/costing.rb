class Costing < ActiveRecord::Base
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
end
