class SasFrontController < ApplicationController
  def index
  end

  def reports
  end
  
  def mail
    UserMailer.sas_mail(1,1).deliver
  end

end
