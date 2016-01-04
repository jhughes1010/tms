class AdminController < ApplicationController
  def login
    if request.post?
      user=User.authenticate(params[:name],params[:password])
      if user
        session[:user_id]=user.id
        session[:user_name]=user.name
        session[:user_fullname]=user.fullname
        session[:user_auth]=user.auth_level
        session[:user_team]=user.team
        #session[:user_auth]=user.authlevel
        flash.now[:notice] = "You are IN!!"
        redirect_to(:action => "/main/index")
      else
        flash.now[:notice]="Invalid user/password combination"
      end
    end
  end
  
  def logout
    session[:user_id]=nil
    flash[:notice]="Logged out"
    redirect_to(:action => "login")
  end
  
  def index
    @full_name=session[:user_fullname]
  end
  
end
