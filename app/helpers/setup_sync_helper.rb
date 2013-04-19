module SetupSyncHelper
  def highlight_new( position, record, targets, targets_device, td_tab, wildcard)
    flag =1
    #check to device-tab matches
    flag = check_device_tab(flag, td_tab, record, position)
    flag = check_wildcard(flag, targets_device, td_tab, record, position)
    flag = check_device(flag, targets_device, record, position)
    flag = check_default(flag, targets, record, position)
    flag = check_engineering( flag, record, position)
    if (flag == 3)
      '<td> <span class="label label-success">'
    elsif (flag == 1)
      '<td> <span class="label label-important">'
    else
      '<td>'
    end
  end

  def check_wildcard(flag, targets_device_tab, record, position)
    flag = 1
    targets_device_tab.each do |d|
      if (record.device == d.device)
        if (record.tab == d.tab)
          #determine if flag should be set
          if (position == 1)
            #cp1 conditions
            flag =3 if (record.cp1 == d.mav_cp1)
            flag =3 if (record.cp1 == d.mag_cp1)
            flag =3 if (record.cp1 == d.mag_x64_cp1)
          end
          #cp2 *conditions*
          if (position == 2)
            flag =3 if (record.cp2 == d.mav_cp2)
            flag =3 if (record.cp2 == d.mag_cp2)
            flag =3 if (record.cp2 == d.mag_x64_cp2)
          end
          #cp3 conditions
          if (position == 3)
            flag =3 if (record.cp3 == d.mav_cp3)
            flag =3 if (record.cp3 == d.mag_cp3)
            flag =3 if (record.cp3 == d.mag_x64_cp3)
            #nothing here yet
          end
        end
      end
    end
    flag
  end
  def check_device_tab(flag, targets_device_tab, record, position)
    flag = 1
    targets_device_tab.each do |d|
      if (record.device == d.device)
        if (record.tab == d.tab)
          #determine if flag should be set
          if (position == 1)
            #cp1 conditions
            flag =3 if (record.cp1 == d.mav_cp1)
            flag =3 if (record.cp1 == d.mag_cp1)
            flag =3 if (record.cp1 == d.mag_x64_cp1)
          end
          #cp2 *conditions*
          if (position == 2)
            flag =3 if (record.cp2 == d.mav_cp2)
            flag =3 if (record.cp2 == d.mag_cp2)
            flag =3 if (record.cp2 == d.mag_x64_cp2)
          end
          #cp3 conditions
          if (position == 3)
            flag =3 if (record.cp3 == d.mav_cp3)
            flag =3 if (record.cp3 == d.mag_cp3)
            flag =3 if (record.cp3 == d.mag_x64_cp3)
            #nothing here yet
          end
        end
      end
    end
    flag
  end
  def check_device(flag, targets_device, record, position)
    if flag == 1
      targets_device.each do |d|
        if (record.device == d.device)
          #determine if flag should be set
          if (position == 1)
            #cp1 conditions
            flag =3 if (record.cp1 == d.mav_cp1)
            flag =3 if (record.cp1 == d.mag_cp1)
            flag =3 if (record.cp1 == d.mag_x64_cp1)
          end
          #cp2 *conditions*
          if (position == 2)
            flag =3 if (record.cp2 == d.mav_cp2)
            flag =3 if (record.cp2 == d.mag_cp2)
            flag =3 if (record.cp2 == d.mag_x64_cp2)
          end
          #cp3 conditions
          if (position == 3)
            flag =3 if (record.cp3 == d.mav_cp3)
            flag =3 if (record.cp3 == d.mag_cp3)
            flag =3 if (record.cp3 == d.mag_x64_cp3)
          end
          #end
        end
      end
    end
    flag
  end
  def check_default(flag, default, record, position)
    if flag == 1
      default.each do |d|
        #determine if flag should be set
        if (position == 1)
          #cp1 conditions
          flag =3 if (record.cp1 == d.mav_cp1)
          flag =3 if (record.cp1 == d.mag_cp1)
          flag =3 if (record.cp1 == d.mag_x64_cp1)
        end
        #cp2 *conditions*
        if (position == 2)
          flag =3 if (record.cp2 == d.mav_cp2)
          flag =3 if (record.cp2 == d.mag_cp2)
          flag =3 if (record.cp2 == d.mag_x64_cp2)
        end
        #cp3 conditions
        if (position == 3)
          flag =3 if (record.cp3 == d.mav_cp3)
          flag =3 if (record.cp3 == d.mag_cp3)
          flag =3 if (record.cp3 == d.mag_x64_cp3)

        end
      end
    end
    flag
  end
  def check_engineering(flag, record, position)
    if flag == 1
      #determine if flag should be set
      if (position == 1)
        #cp1 conditions
        flag =2 if record.cp1.include?("NONE")
        flag =2 if record.cp1.include?("SPTR")
        flag =2 if record.cp1.include?("NOT_ALLOWED")
        flag =2 if record.cp1.include?("CHECK_PCARD")
      end
      #cp2 *conditions*
      if (position == 2)
        flag =2 if record.cp2.include?("NONE")
        flag =2 if record.cp2.include?("SPTR")
        flag =2 if record.cp2.include?("NOT_ALLOWED")
        flag =2 if record.cp2.include?("CHECK_PCARD")
      end
      #cp3 conditions
      if (position == 3)
        flag =2 if record.cp3.include?("NONE")
        flag =2 if record.cp3.include?("SPTR")
        flag =2 if record.cp3.include?("NOT_ALLOWED")
        flag =2 if record.cp3.include?("CHECK_PCARD")
      end
    end
    flag
  end
end
