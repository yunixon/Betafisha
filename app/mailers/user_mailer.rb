class UserMailer < ActionMailer::Base
  default :from => "admin@betafisha.com"
  
  def registration_confirmation(user)
      @user = user
      mail( :to => user.email, 
            :subject => "[NO REPLY]Account has been registred!" ) 

   end
end
