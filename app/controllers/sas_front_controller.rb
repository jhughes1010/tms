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
    UserMailer.scrap(['james.hughes@atmel.com', 'lisa.dougan@atmel.com', 'jeff.leasure@atmel.com', 'james.lutinski@atmel.com'], @uploaded_io.original_filename).deliver
    
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
      row = 12
      col = 1
      while xls.cell(row, col) != nil do
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
    record.sent = true
    record.sas_type = "Obsolete"
    record.lot_number = row[0]
    record.location = row[1]
    record.profit_center = row[2]
    record.sap_matid = row[3]
    record.lts_matid = row[4]
    record.quantity = row[5]
    record.comment = row[10]
    record.save  
  end
  
  def abnormalScrap(row)
    #create record and save it
    record = Sa.new
    record.sent = true
    record.sas_type = "Abnormal"
    record.lot_number = row[0]
    record.location = row[1]
    record.plant = row[2]
    record.profit_center = row[3]
    record.sap_matid = row[4]
    record.lts_matid = row[5]
    record.quantity = row[6]
    record.comment = row[10]
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
