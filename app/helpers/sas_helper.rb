module SasHelper
  def checkbox_mail(flag)
    if ( flag ) 
      '<span class="glyphicon glyphicon-ok-sign">'
    else
      '<span class="glyphicon glyphicon-envelope">'
    end
  end
  def checkbox(flag)
    if ( flag ) 
      '<span class="glyphicon glyphicon-ok-sign">'
    else
      '<span class="glyphicon glyphicon-unchecked">'
    end
  end
end
