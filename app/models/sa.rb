class Sa < ActiveRecord::Base
  def self.mask_set(entry)
    mask = Hash.new
    if entry == "Abnormal"
      mask = {lot_number: true,
        location: true,
        profit_center: true,
        sap_matid: true,
        lts_matid: true,
        quantity: true,
        date: true,
        created_at: true,
        updated_at: true,
        sas_type: true,
        sent: true,
        comment: true
      }
    elsif entry == "Obsolete"
      mask = {lot_number: true,
        location: true,
        plant: true,
        profit_center: true,
        sap_matid: true,
        lts_matid: true,
        quantity: true,
        date: true,
        created_at: true,
        updated_at: true,
        sas_type: true,
        sent: true,
        comment: true
      }
    else
      mask.default = true
    end
    mask
  end
end  