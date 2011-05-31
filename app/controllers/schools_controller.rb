class SchoolsController < ApplicationController
  autocomplete :school, :name
  
  def show
    @school = School.find params[:id]
    @laboratories = @school.laboratories
  end
end
