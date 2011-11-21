class UserMailer < ActionMailer::Base
  default :from => "team@labcollaborate.com"
  
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
  
  def welcome_notification(user)
    @user = user
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Welcome to Lab Collaborate!")
  end
  def send_message(user, sender, title, message)
    @user = user
    @sender = sender
    @title = title
    @message = message
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "#{@title}", :from => "Lab Collaborate <#{@sender.email}>")
  end
  
end
