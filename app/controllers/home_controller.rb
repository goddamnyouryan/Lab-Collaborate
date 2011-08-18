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
  
  def choose_university
    @schools = School.all
    @school = School.new
  end
  
  def update_school
    @school = School.find_or_create_by_name(params[:school_id])
    current_user.update_attributes(:school_id => @school.id)
    redirect_to root_path
  end
  
  def find_lab
    @labs = Laboratory.find :all, :conditions => ["school_id = ?", current_user.school_id ]
  end
  
  def search
    @laboratories = Laboratory.where("lower(name) LIKE ? OR lower(info) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    @users = User.where(
                  "lower(email) LIKE ? OR lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(fullname) LIKE ? OR lower(info) LIKE ?",
                  "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"
                  )
   @schools = School.where("lower(name) LIKE ?", "%#{params[:search].downcase}%")
  end
  
end
