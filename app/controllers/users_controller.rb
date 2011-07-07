class UsersController < ApplicationController
  
  def show 
    @user = User.find params[:id]
  end
  
  def make_admin
    @user = User.find params[:user_id]
    @user.make_admin
    flash[:notice] = "test"
    redirect_to root_path
  end
  
end
