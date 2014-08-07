class SasFrontController < ApplicationController
    before_filter :set_useful_globals
  def index
  end

  def reports
  end
  
  def mail
        @sa = Sa.find(params[:id])
    #debug - hardcoded
    UserMailer.sas_mail(@user_id,@sa).deliver
  end
  
  def upload
    @uploaded_io = params[:spreadsheet]
    puts "upload is being called"
    File.open(Rails.root.join('public', 'uploads', @uploaded_io.original_filename), 'wb') do |file|
      file.write(@uploaded_io.read)
    end
  end
  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @today=Date.today
    @today.to_s(:long)
  end
end
