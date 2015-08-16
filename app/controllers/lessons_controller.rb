class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_enrollment, :only => [:show]

  def show
    if !lesson_exists
      render :text => "Not Found",  :status => :not_found  
    end
  end

  private

  helper_method :current_lesson

  def require_user_enrollment
    if lesson_exists
      if !current_user.enrolled_in?(current_lesson.section.course)
        redirect_to course_path(current_lesson.section.course), :alert => 'You must be enrolled to view this lesson'
      end
    end
  end

  def lesson_exists
    !Lesson.where(:id => params[:id]).blank?
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end

