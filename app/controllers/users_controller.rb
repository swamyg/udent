class UsersController < ApplicationController
   
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
  # GET /users
  # GET /users.json
  def index
    if @admin
      @users = User.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:error] = "Hello #{@user.name}, you don't have Admin permission"
      redirect_to new_session_path 
    end  
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @allcourses = Course.all
    @user = User.find(params[:id])
    @courses = @user.courses.sort
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
    
  end

  def addcourse
    @user = User.find(params[:id])
    @courses = Course.find_by_course_name(params[:course_name])
    @user.courses << @courses
    @user.save
    redirect_to show_user_path(@user)  
  end
  def dropcourse
    @user = User.find(params[:id])
    @courses = Course.find_by_course_name(params[:course_name])
    @user.courses.delete(@courses)
    @user.save
    redirect_to show_user_path(@user)  
  end

  def profile
    @user = User.find(params[:id])
    @courses =@user.courses.sort

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def new
    
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
   
  end
  
  def create 
    @user = User.new(params[:user])
   
   
    respond_to do |format|
      if @user.save
         session[:user_id] = @user.id
        @loggedin = true
        flash[:notice] = " Welcome #{@user.name}, Now you Start adding courses "
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  end
  end
  


  # GET /users/1/edit
  def edit
   
    @user = User.find(params[:id])
     
  end

  def delete
   if @admin
   @user = User.find(params[:id])
   @user.destroy
    
   respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
   end
   else
      flash[:error] = "Hello #{@user.name}, you don't have Admin permission"
      redirect_to new_session_path
   end  
  end
end
