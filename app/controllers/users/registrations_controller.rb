class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :user_event, :only => :update
  
  def user_event
    @user.laboratory.events.create(:kind => "profile", :data => { "user_id" => "#{@user.id}", "user_name" => "#{@user.name}" })
  end
end