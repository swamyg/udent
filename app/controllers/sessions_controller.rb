class SessionsController < ApplicationController
 before_filter :access_level
 
  def access_level
    if @user = User.find_by_id(session[:user_id])
      @loggedin = true
      if @user = User.find_by_id(session[:user_id]).admin 
        @admin = true
      else
        @admin = false
     end
    else
     @loggedin = false 
    end 
  end 

 
  def register
    @user = @user || User.new
  end

  def login 
  end
  
  def new 
    @user = @user || User.new
  end
  
  def loginvalidate
    if @user = User.find_by_email(params[:email])
      if params[:password] == @user.password
        session[:user_id] = @user.id
        flash[:success] = "Hello #{@user.name}, Welcome "
        redirect_to @user
      else
        flash[:error] = "Invalid Password"
        redirect_to create_session_path
      end  
    else
      flash[:error] = "The Email you have entered does not exsist"
      redirect_to create_session_path
    end  
  end
  
  def logout
    session[:user_id] = nil
    @admin = false
    @loggedin = false
    redirect_to new_session_path
  end
end
 