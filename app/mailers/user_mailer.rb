class UserMailer < ActionMailer::Base
  
  default :from => "no_reply@betafisha.com"
  
  def registration_confirmation ( user )
      @user = user
      mail( :to => user.email, 
            :subject => "[NO REPLY] BetAfisha: Account has been registred!" ) 
   end
   
   def reset_password ( user )
      @user = user
       mail( :to => user.email, 
             :subject => "[NO REPLY] BetAfisha: Reset password!" ) 
   end
   
end
