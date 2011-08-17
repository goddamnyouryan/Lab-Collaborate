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
  
  def edit
    @user = User.find params[:id]
    unless current_user == @user || current_user.role == "admin"
      redirect_to root_path, :notice => "You're not allowed there!"
    end
  end
  
  def update
    @user = User.find params[:id]
    unless current_user == @user || current_user.role == "admin"
      redirect_to root_path, :notice => "You're not allowed there!"
    end
    @user.update_attributes(params[:user])
    if @user.first_name.nil? || @user.last_name.nil?
      @user.fullname = @user.email
    else
      @user.fullname = [@user.first_name, @user.last_name].join(" ")
    end
    if @user.save
      redirect_to @user, :notice => "Profile Updated!"
    end
  end
  
end
