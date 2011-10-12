class LaboratoriesController < ApplicationController
  after_filter :friend_event, :only => :accept_friend
  after_filter :affiliate_event, :only => :accept_affiliate
  
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
      current_user.make_admin
      redirect_to laboratory_invite_path(@laboratory), :notice => "Created #{@laboratory.name}!"
    end
  end

  def edit
  end

  def update
    @laboratory = Laboratory.find params[:id]
    @laboratory.update_attributes(params[:laboratory])
    respond_to do |format|
      format.js
      format.html { redirect_to @laboratory, :notice => "info updated." }
    end
  end

  def destroy
    @laboratory = Laboratory.find params[:id]
    @laboratory.destroy
    redirect_to schools_path
  end
  
  def show
    @laboratory = Laboratory.find params[:id]
    @whiteboard = Whiteboard.new
  end
  
  def library
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols
    if params[:search]
      @protocols = @protocols.where("LOWER(name) LIKE ? AND laboratory_id = ?", "%#{params[:search].to_s.downcase}%", @laboratory.id)
      @protocols = @protocols | @laboratory.protocols.tagged_with(params[:search])
    end
  end
  
  def protocols
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols.where("category = ?", "protocol")
  end
  
  def papers
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols.where("category = ?", "paper")
  end
  
  def presentations
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols.where("category = ?", "presentation")
  end
  
  def data
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols.where("category = ?", "data")
  end
  
  def pictures
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
    @protocols = @laboratory.protocols.where("category = ?", "picture")
  end
  
  def members
    @laboratory = Laboratory.find params[:laboratory_id]
  end
  
  def activity_stream
    @laboratory = Laboratory.find params[:laboratory_id]
    if user_signed_in? && current_user.laboratory == @laboratory
    	@activity_stream = Event.where("laboratory_id in (?)", @laboratory.collaborators.map(&:id).push(@laboratory.id)).order("created_at DESC").limit(100)
    elsif user_signed_in? && @laboratory.collaborators.include?(current_user.laboratory)
    	@activity_stream = Event.where("laboratory_id = ?", @laboratory.id).order("created_at DESC").limit(100)
    end
  end
  
  def invite
    @laboratory = Laboratory.find params[:laboratory_id]
  end
  
  def send_invites
    @emails = params[:emails].gsub(/\s+/, "").split(",")
    @users = Array.new
    @emails.each do |email|
      password = ActiveSupport::SecureRandom.base64(6)
      user = User.create(:email => email, :password => password, :password_confirmation => password, :school_id => current_user.school_id)
      if user.save
        @users << user
        affiliation = Affiliation.create(:user_id => user.id, :laboratory_id => current_user.laboratory.id, :status => "accepted")
        UserMailer.deliver_invite_notification(user, current_user, password)
        @event = current_user.laboratory.events.create(:kind => "affiliate", :data => { "user_id" => "#{user.id}", "name" => "#{email}"})
      end
    end
    redirect_to edit_user_path(@users.first), :notice => "Signed Colleagues up as members of your lab! Now add some info about them!"
  end
  
  def add_affiliate
    @affiliation = Affiliation.create(:user_id => current_user.id, :laboratory_id => params[:laboratory_id])
    @laboratory = Laboratory.find params[:laboratory_id]
    if @affiliation.save
      redirect_to root_path, :notice => "The admin of #{@laboratory.name} have been informed. We'll email you when you have access to this lab."
    end
  end
  
  def accept_affiliate
    @laboratory = Laboratory.find params[:laboratory_id]
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
  
  def remove_affiliate
    @affiliation = Affiliation.find_by_user_id_and_laboratory_id(params[:user_id], params[:laboratory_id])
    @affiliation.destroy
    @user = User.find params[:user_id]
    redirect_to root_path, :notice => "#{@user.name} removed."
  end
  
  def add_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.add_friend(@friend, current_user)
    @friend.users.where("role = ?", "admin").each do |user|
      UserMailer.deliver_friend_request(user, @laboratory)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to @friend }
    end
  end
  
  def accept_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.accept_friendship(@friend, current_user)
    @laboratory.users.each do |user|
      UserMailer.deliver_friend_notification(user, @friend)
    end
    @friend.users.each do |user|
      UserMailer.deliver_friend_notification(user, @laboratory)
    end
    redirect_to root_path, :notice => "You are now collaborating with #{@laboratory.name}."
  end
  
  def decline_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.decline_friendship(@friend)
    redirect_to root_path, :notice => "Friendship with #{@laboratory.name} declined."
  end
  
  def remove_friend
    @laboratory = current_user.laboratory
    @friend = Laboratory.find params[:laboratory_id]
    @laboratory.remove_friendship(@friend)
    redirect_to root_path, :notice => "Friendship with #{@laboratory.name} declined."
  end
  
  def edit_info
    @laboratory = Laboratory.find params[:laboratory_id]
    respond_to do |format|
      format.js
      format.html { redirect_to edit_laboratory_path(@laboratory) }
    end
  end
  
  def friend_event
    event = @laboratory.events.create(:kind => "friend", :data => { "friend" => "#{@friend.id}", "name" => "#{@friend.name}" })
		friend = @friend.events.create(:kind => "friend", :data => { "friend" => "#{@friend.id}", "name" => "#{@friend.name}" } )
	end
	
	def affiliate_event
	  @event = @laboratory.events.create(:kind => "affiliate", :data => { "user_id" => "#{@user.id}", "name" => "#{@user.name}"})
  end
  
end
