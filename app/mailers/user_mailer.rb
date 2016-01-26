# app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "crypto_bu_tools@atmel.com"  # , :cc => "jhughes1010@gmail.com, james.hughes@atmel.com"

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
    @review=list
    @user=User.find(user_id)
    name=@user.fullname
    email=@user.email
    #email="james.hughes@atmel.com"
    #send mail
    mail(:to => "#{name} <#{email}>",:cc => "james.hughes@atmel.com, john.groat@atmel.com", :subject => "TMS - My Task Summary: " + name)
  end

  def setup_import_complete(recipient)
    mail(:to => recipient.join(','), :subject => "SETUP - Daily Import Completed") 
  end 
  def sas_mail(recipient, attachment)
    path = './public/uploads/'
    file = path + attachment
    attachments['scrap.xlsx'] = File.read(file)
    mail(:to => recipient.join(','), :subject => "Scrap Event is attached") 
  end 
end
