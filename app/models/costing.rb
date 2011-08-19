class Costing < ActiveRecord::Base
  def self.search(params)
    scoped
    results = self.where("device like ?", "%" + params[:device] + "%") if params[:device]
    #products.where("price >= ?", params[:price_gt]) if params[:price_gt]
    #products.where("price <= ?", params[:price_lt]) if params[:price_lt]
    results
  end

  def self.scope_builder
    DynamicDelegator.new(scoped)
  end
end
