class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      if current_user.school_id?
        if current_user.laboratory.nil?
          if current_user.pending_laboratory.nil?
            redirect_to find_lab_path
          else
            redirect_to laboratory_path(current_user.pending_laboratory)
          end
        else
          redirect_to laboratory_path(current_user.laboratory)
        end
      else
        redirect_to choose_school_path
      end
    else
      
    end
  end
  
  def update_school
    @school = School.find_or_create_by_name(params[:school_id])
    current_user.update_attributes(:school_id => @school.id)
    redirect_to root_path
  end
  
  def find_lab
    @labs = Laboratory.find :all, :conditions => ["school_id = ?", current_user.school_id ]
  end
  
end
