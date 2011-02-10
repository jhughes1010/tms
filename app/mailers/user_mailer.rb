# app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  default :from => "james.hughes@atmel.com"
  
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
    #email="james.hughes@atmel.com"
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{name} <#{email}>", :subject => "TMS - New Task Entry Confirmation")
  end
  def daily_report(user_id, list)
    #test case
    @active=list
    @user=User.find(user_id)
    name=@user.fullname
    #email="james.hughes@atmel.com"  
    email=@user.email
    #send mail
        mail(:to => "#{name} <#{email}>", :subject => "TMS - My Weekly Task Summary")
  end
end
