module SasHelper
  def checkbox(flag)
    if ( flag ) 
      '<span class="glyphicon glyphicon-ok-sign">'
    else
      '<span class="glyphicon glyphicon-unchecked">'
    end
  end
end
