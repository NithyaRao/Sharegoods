class MessageMailer < ApplicationMailer
  default to: "bumblebeenr@gmail.com"

  def new_message(message)
    @message = message
    mail(subject: 'Message from ' + message.name , from: message.email )
  end

end
