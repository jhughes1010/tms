class Finance

  def group_actuals_by_quarter( dataset)
    quarter_data = Hash.new(0)
    dataset.each do |d|
      hash_tag = d.date.year.to_s
      hash_tag += "-" + d.date.month/4)+1).to_s
      quarter_data[hash_tag] += d.actual
      puts hash_tag
    end
  end
  quarter_data
end

