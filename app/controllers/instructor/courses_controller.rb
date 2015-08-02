class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, :only => [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    if !course_exists
      render :text => "Not Found",  :status => :not_found  
    end
  end

  private

  def require_authorized_for_current_course
    if course_exists
      if current_course.user != current_user
        render :text => "Unauthorized", :status => :unauthorized
      end
    end
  end

  def course_exists
    !Course.where(:id => params[:id]).blank?
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.required(:course).permit(:title, :description, :cost)
  end

end
