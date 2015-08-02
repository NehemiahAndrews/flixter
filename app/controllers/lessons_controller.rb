class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    if !lesson_exists
      render :text => "Not Found",  :status => :not_found  
    end
  end

  private

  helper_method :current_lesson

  def lesson_exists
    !Lesson.where(:id => params[:id]).blank?
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end

