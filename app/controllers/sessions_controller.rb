class SessionsController < ApplicationController
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
        flash[:success] = "Sucessfully Loggedin "
        redirect_to @user
      else
        flash[:error] = "Invalid Password"
        redirect_to create_session_path
      end  
    else
      flash[:error] = "User does not Exsist"
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
 