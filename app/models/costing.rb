class Costing < ActiveRecord::Base
  def self.search(params)
    results = scoped
    results = results.where("device like ?", "%" + params[:device] + "%") if params[:device]
    results = results.where("pc like ?", "%" + params[:pc] + "%") if params[:pc]
    #products.where("price <= ?", params[:price_lt]) if params[:price_lt]
    results
  end

  def self.scope_builder
    DynamicDelegator.new(scoped)
  end
end
