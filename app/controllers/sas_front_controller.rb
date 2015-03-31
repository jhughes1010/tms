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
    UserMailer.sas_mail(['james.hughes@atmel.com', 'mike.flanagan@atmel.com', 'james.lutinski@atmel.com', 'karey.klaus@atmel.com', 'jane.stang@atmel.com'], @uploaded_io.original_filename).deliver
    
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
      #better logic here?
      row = 11
      col = 2
      if name == "Abnormal Scrap"
        row = 12
      end
      while xls.cell(row, col) != nil do
        #better logic here?
        current_row = sheet.row( row)
        #puts current_row[0]
        if name == "E_O Scrap"
          eoScrap (current_row)
        elsif name == "Abnormal Scrap"
          abnormalScrap (current_row)
        end
        row += 1
      end
    end
  end
  
  def deleteSa
      Sa.delete_all
      flash.now[:notice] = "SAS records deleted"
      redirect_to(:action => "/main/sas_front/index")
      
    end

  def eoScrap(row)
    #create record and save it
    record = Sa.new
    record.user_id = @user_id
    record.sent = true
    record.date = Date.today()
    record.sas_type = "Obsolete"
    record.lot_number = row[1]
    record.location = row[2]
    record.owner = row[4]
    record.lts_matid = row[6]
    record.quantity = row[7]
    record.comment = row[12]
    record.save  
  end
  
  def abnormalScrap(row)
    #create record and save it
    record = Sa.new
    record.user_id = @user_id
    record.sent = true    
    record.sas_type = "Abnormal"
    record.lot_number = row[1]
    record.location = row[2]
    record.owner = row[5]
    record.lts_matid = row[7]
    record.quantity = row[8]
    record.date = row[12]
    record.comment = row[13]
    record.save  
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
