module SetupSyncHelper
  def highlight_new( position, record, targets, targets_device, targets_device_tab)
    flag =1
    #check to device-tab matches
    flag = check_device_tab(targets_device_tab, record, position)
    #flag = check_device(targets_device, record, position)
    #flag = check_device(targets, record, position)
    #flag = check_other( record, position)
    if (flag == 3)
      '<td bgcolor="#67e667">'
    elsif (flag == 2)
      '<td bgcolor="#ffff73">'
    elsif (flag == 1)
      '<td bgcolor="#ff8373">'
    else
      '<td>'
    end
  end
  def highlight( position, record, targets)
    flag =1
    #determine if flag should be set
    if (position == 1)
      #cp1 conditions
      flag =3 if (record.cp1 == targets[0].mag_cp1)
      flag =3 if (record.cp1 == targets[0].mag_x64_cp1)
      flag =2 if record.cp1.include?("NONE")
      flag =2 if record.cp1.include?("SPTR")
      flag =2 if record.cp1.include?("NOT_ALLOWED")
    end
    #cp2 *conditions*
    if (position == 2)
      flag =3 if (record.cp2 == targets[0].mag_cp2)
      flag =3 if (record.cp2 == targets[0].mag_x64_cp2)
      flag =2 if record.cp2.include?("NONE")
      flag =2 if record.cp2.include?("SPTR")
      flag =2 if record.cp2.include?("NOT_ALLOWED")
    end
    #cp3 conditions
    if (position == 3)
      #flag =3 if (record.cp3 == targets[0].mag_cp3)
      #flag =3 if (record.cp3 == targets[0].mag_x64_cp3)
      flag =2 if record.cp3.include?("NONE")
      flag =2 if record.cp3.include?("SPTR")
      flag =2 if record.cp3.include?("NOT_ALLOWED")
    end
    if (flag == 3)
      '<td bgcolor="#67e667">'
    elsif (flag == 2)
      '<td bgcolor="#ffff73">'
    elsif (flag == 1)
      '<td bgcolor="#ff8373">'
    else
      '<td>'
    end
  end
  def check_device_tab(targets_device_tab, record, position)
    flag = 1
    targets_device_tab.each do |d|
      if (record.device == d.device)
        if (record.tab == d.tab)
          #determine if flag should be set
          if (position == 1)
            #cp1 conditions
            flag =3 if (record.cp1 == targets[0].mag_cp1)
            flag =3 if (record.cp1 == targets[0].mag_x64_cp1)
          end
          #cp2 *conditions*
          if (position == 2)
            flag =3 if (record.cp2 == targets[0].mag_cp2)
            flag =3 if (record.cp2 == targets[0].mag_x64_cp2)
          end
          #cp3 conditions
          if (position == 3)
            #flag =3 if (record.cp3 == targets[0].mag_cp3)
            #flag =3 if (record.cp3 == targets[0].mag_x64_cp3)
          end
        end
      end
    end
    flag
  end
end
