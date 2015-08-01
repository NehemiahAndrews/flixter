class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!, :only => [:new,:create]
 
  def new
    @course = Course.find(params[:course_id])
    if current_user
      @section = Section.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if current_user
      @course = Course.find(params[:course_id])
      @section = @course.sections.create(section_params)
      if @section.valid?
        redirect_to instructor_course_path(@course)
      else
        render :new, :status => :unprocessable_entity
      end
    else
      redirect_to new_user_session_path
    end
  end

  private

  def section_params
    params.required(:section).permit(:title)
  end

end
