# app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "james.hughes@atmel.com"  # , :cc => "jhughes1010@gmail.com, james.hughes@atmel.com"


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
    #name="James Hughes"
    #email="james.hughes@atmel.com"**
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{name} <#{email}>", :subject => "TMS - New Task Entry Confirmation")
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
  def sas_mail(user_id, sas_id)
    @sa = Sa.find(sas_id)
    #nothing about the user is in play yet
    @user = User.find(user_id)
    name = @user.fullname
    email = @user.email
    #resolve BP contact info
    @bp_name = "Lori Hughes"
    @bp_email = "lorilynn1988@gmail.com"
    mail(:to => "#{@bp_name} <#{@bp_email}>", :subject => "SAS - report of scrap incident")
    #open record and mark :sent as true
    @sa.sent = true
    @sa.save
  end
end
