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
    File.open(Rails.root.join('public', 'uploads', @uploaded_io.original_filename), 'wb') do |file|
      file.write(@uploaded_io.read)
    end
    write_records( @uploaded_io)
    #send_mail( recipient, file)
  end
  def send_mail( recipient, file)
    
  end
  def write_records( file)
    #open file
    path = './public/uploads/'
    file = path + file.original_filename
    xls = Roo::Spreadsheet.open( file.to_s)
    #itterate through lines while (r,c) is not nil
    xls.each_with_pagename do |name, sheet|
      p name
      p sheet.row(11)
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
