class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    if Course.where(:id => params[:id]).blank?
      render :text => "Not Found",  :status => :not_found  
    else
      @course = Course.find(params[:id])
    end
  end
end
