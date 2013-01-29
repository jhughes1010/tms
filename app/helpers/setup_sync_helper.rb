module SetupSyncHelper
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
    #cp2 conditions
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
    '<td bgcolor="green">'
  elsif (flag == 2)
    '<td bgcolor="yellow">'
  elsif (flag == 1)
    '<td bgcolor="red">'
  end
end
def normal

end

end
