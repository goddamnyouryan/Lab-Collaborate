class UserMailer < ActionMailer::Base
  default :from => "no-reply@labcollaborate.com"
  
  def invite_notification(user, inviter, password)
    @user = user
    @inviter = inviter
    @password = password
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "#{@inviter.name} signed you up for Lab Collaborate!")
  end
end
