class MemberNotifier < ApplicationMailer
     
  def invitation(invitation, fromemail)
   #debugger
    @invitation = invitation
  # @url = 'http://www.google.com'
    mail(to: invitation.recipient_email, subject: 'ShareGoods invitation to Join ', from: fromemail)
  
    invitation.update_attribute(:sent_at, Time.now)
  end
end
