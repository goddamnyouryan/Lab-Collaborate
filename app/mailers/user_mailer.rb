class UserMailer < ActionMailer::Base
  default :from => "no-reply@labcollaborate.com"
  
  def invite_notification(user, inviter, password)
    @user = user
    @inviter = inviter
    @password = password
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "#{@inviter.name} signed you up for Lab Collaborate!")
  end
  
  def friend_request(user, laboratory)
    @user = user
    @laboratory = laboratory
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Friend request from #{@laboratory.name}")
  end
  
  def friend_notification(user, laboratory)
    @user = user
    @laboratory = laboratory
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Your lab is now friends with #{@laboratory.name}")
  end
end
