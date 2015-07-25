class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def new
    @course = Course.new
  end

  def create
    if defined?(current_user) != nil
      @course = current_user.courses.create(course_params)
      if @course.valid?
        redirect_to instructor_course_path(@course)
      else
        render :new, :status => :unprocessable_entity
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if Course.where(:id => params[:id]).blank?
      render :text => "Not Found",  :status => :not_found  
    else
      @course = Course.find(params[:id])
    end
  end

  private

  def course_params
    params.required(:course).permit(:title, :description, :cost)
  end

end
