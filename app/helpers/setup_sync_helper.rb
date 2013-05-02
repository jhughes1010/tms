module SetupSyncHelper
  def highlight(flag)
    if ( flag == 1) #no match
      '<span class="label label-important">'
    elsif( flag == 2) #engineering match
      '<span class="label label-warning">'
    elsif( flag == 3) #matches a target table entry
      '<span class="label label-success">'
    end
  end
end
