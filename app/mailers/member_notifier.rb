class MemberNotifier < ApplicationMailer
     
  def invitation(invitation, fromemail)
   #debugger
    @invitation = invitation
  # @url = 'http://www.google.com'
    mail(to: invitation.recipient_email, subject: 'ShareGoods invitation to Join ', from: fromemail)
  
    invitation.update_attribute(:sent_at, Time.now)
  end

  def accept_request(request, requestoremail, requestorname, groupname, fromemail)
  #  debugger 
    @request = request
    @requestorname = requestorname
    @requestoremail = requestoremail
    @requestoremailname = %("#{@requestorname}" <#{@requestoremail}>)
    @groupname = groupname
  
    @fromemail = fromemail
    @itemname = @request.item.name
  # @url = 'http://www.google.com'
    mail(to: @requestoremailname, subject: 'ShareGoods: Request for: '+ @itemname + ' is accepted', from: @fromemail)
  end

  def notify_requestor(wishitem, requestoremail, requestorname, groupname, fromemail)

    @wishitem= wishitem
    @requestorname = requestorname
    @requestoremail = requestoremail
    @requestoremailname = %("#{@requestorname}" <#{@requestoremail}>)
    @groupname = groupname
    @fromemail = fromemail
   # @url = 'http://www.google.com'
    mail(to: @requestoremailname, subject: 'ShareGoods: Wishitem : '+ @wishitem.name + ' is available for sharing', from: @fromemail)
  end
end
