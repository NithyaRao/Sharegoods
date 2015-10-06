class Mailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
 # def invitation(invitation, signup_url)
 # debugger
 # subject    'Invitation'
#  recipients invitation.recipient_email
#  from       'foo@example.com'
#  body       :invitation => invitation, :signup_url => signup_url
#  invitation.update_attribute(:sent_at, Time.now)
#  end

  def invitation(invitation)
  #debugger
  @invitation = invitation
  @url = 'http://www.google.com'
  mail(to: invitation.recipient_email, subject: 'Invitation',from: 'foo@example.com')
  
  invitation.update_attribute(:sent_at, Time.now)
  end

end
