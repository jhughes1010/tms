class Sa < ActiveRecord::Base

  belongs_to :user

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
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    puts "ROO file upload: #{file.original_filename}" 
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end  