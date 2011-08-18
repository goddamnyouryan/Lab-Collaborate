class SchoolsController < ApplicationController
  
  def show
    @school = School.find params[:id]
    @laboratories = @school.laboratories
  end
  
  def index
    unless user_signed_in? && current_user.role == "admin"
      redirect_to root_path
    end
    @schools = School.all
  end
  
  def edit
    @school = School.find params[:id]
    current_user.update_attributes(:school_id => @school.id)
    redirect_to root_path
  end
  
  def create
    @school = School.create params[:school]
    if @school.save
      current_user.update_attributes(:school_id => @school.id)
      redirect_to root_path, :notice => "#{@school.name} created!"
    end
  end
  
  def destroy
    @school = School.find params[:id]
    @school.destroy
    redirect_to schools_path
  end
  
end
