class Sa < ActiveRecord::Base
  def self.mask_set(entry)
    mask = Hash.new
    mask.default = true
    if entry == "Abnormal"
      mask = {lot_number: true}
    elsif entry == "Obsolete"
      mask = {lot_number: true}
    else
      mask.default = true
    end
    mask
  end
end
