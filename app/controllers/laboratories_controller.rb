class LaboratoriesController < ApplicationController
  def index
  end

  def new
    @laboratory = Laboratory.new
  end

  def create
    @laboratory = Laboratory.create(params[:laboratory])
    @laboratory.update_attributes(:school_id => current_user.school_id)
    @affiliation = Affiliation.create(:user_id => current_user.id, :laboratory_id => @laboratory.id, :status => "accepted")
    if @laboratory.save
      redirect_to @laboratory, :notice => "Created #{@laboratory.name}!"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def show
    @laboratory = Laboratory.find params[:id]
    @protocol = Protocol.new
    @whiteboard = Whiteboard.new
  end
  
  def add_affiliate
    @affiliation = Affiliation.create(:user_id => current_user.id, :laboratory_id => params[:laboratory_id])
    @laboratory = Laboratory.find params[:laboratory_id]
    if @affiliation.save
      redirect_to root_path, :notice => "The admin of #{@laboratory.name} have been informed. We'll email you when you have access to this lab."
    end
  end
  
  def accept_affiliate
    @affiliation = Affiliation.find_by_user_id_and_laboratory_id(params[:user_id], params[:laboratory_id])
    @affiliation.update_attributes(:status => "accepted")
    @user = User.find params[:user_id]
    redirect_to root_path, :notice => "#{@user.name} added to your lab."
  end
  
  def decline_affiliate
    @affiliation = Affiliation.find_by_user_id_and_laboratory_id(params[:user_id], params[:laboratory_id])
    @affiliation.destroy
    @user = User.find params[:user_id]
    redirect_to root_path, :notice => "#{@user.name} declined."
  end
  
  def add_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.add_friend(@friend, current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @friend }
    end
  end
  
  def accept_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.accept_friendship(@friend, current_user)
    redirect_to root_path, :notice => "You are now collaborating with #{@laboratory.name}."
  end
  
  def decline_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.decline_friendship(@friend)
    redirect_to root_path, :notice => "Friendship with #{@laboratory.name} declined."
  end
  
end
