class CoursesController < ApplicationController
  
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

  def index
     @course = Course.all     
     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    if @admin
      @course = Course.new
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course } 
      end   
    else
      flash[:error] = "You don't have permission add courses"
      redirect_to new_session_path
    end   
  end

  # GET /courses/1/edit
  def edit
     if @admin
      @course = Course.find(params[:id])      
    else
      flash[:error] = "You don't have permission edit courses"
      redirect_to index_course_path
    end 
  end

  # POST /courses
  # POST /courses.json
  def create
    if @admin
    @course = Course.new(params[:course])
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  
    else
      flash[:error] = "You don't have permission add courses"
      redirect_to index_course_path 
    end 
    
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    if @admin
    @course = Course.find(params[:id])
    @course.destroy
   flash[:notice] = "Course #{@course.course_name} is deleted"
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
   else
    flash[:error] = "You don't have permission add courses"
    redirect_to index_course_path  
   end   
  end
end
