# app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "memory_bu_tools@atmel.com"  # , :cc => "jhughes1010@gmail.com, james.hughes@atmel.com"


  def registration_confirmation(user)
    @user = user
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "TMS Registration received")
  end
  def task_entry_confirmation(user_id, task)
    @task = task
    @user = User.find(user_id)
    name = @user.fullname
    email = @user.email
    mail(:to => "#{name} <#{email}>", :subject => "TMS - New Task Entry Confirmation")
  end
  def task_edit_confirmation(user_id, task)
    @task = task
    @user = User.find(user_id)
    name = @user.fullname
    email = @user.email
    mail(:to => "#{name} <#{email}>", :subject => "TMS - Task Edit Confirmation")
  end
  def pto_entry_confirmation(user_id, regarding_id, pto)
    @pto = pto
    @user = User.find(user_id)
    @name = @user.fullname
    email = @user.email
    #Determine who the request was made by
    @regarding = User.find(regarding_id)
    @regarding_name = @regarding.fullname
    mail(:to => "#{@name} <#{email}>", :subject => "TMS - New PTO Entry Confirmation")
  end
  def daily_report(user_id, list)
    #test case
    @active=list
    @user=User.find(user_id)
    name=@user.fullname
    #email="james.hughes@atmel.com"
    email=@user.email
    #send mail
    mail(:to => "#{name} <#{email}>", :subject => "TMS - My Task Summary: " + name)
  end
  def sas_mail_old(user_id, sas_id)
    @sa = Sa.find(sas_id)
    #nothing about the user is in play yet
    @user = User.find(user_id)
    name = @user.fullname
    email = @user.email
    #resolve BP contact info
    @bp_name = "Atmel Scrap Dist List"
    @bp_email = "scrap_atmel@cso.atmel.com"
    mail(:to => "#{@bp_name} <#{@bp_email}>", :subject => "SAS - report of scrap incident")
    #open record and mark :sent as true
    @sa.sent = true
    @sa.save
  end
  def setup_import_complete(recipient)
    mail(:to => recipient.join(','), :subject => "SETUP - Daily Import Completed") 
  end 
  def sas_mail(recipient, attachment)
    path = './public/uploads/'
    file = path + attachment
    attachments['scrap.xls'] = File.read(file)
    mail(:to => recipient.join(','), :subject => "Scrap Event is attached") 
  end 
end
