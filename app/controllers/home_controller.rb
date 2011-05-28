class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      if current_user.school_id?
        
      else
        redirect_to choose_school_path
      end
    else
      
    end
  end
  
  def choose_university
    
  end
  
end
