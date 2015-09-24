class InvitationsController < ApplicationController

def new
  #debugger
  @invitation = Invitation.new

end

def create
  @invitation = Invitation.new(invitation_params)

  @invitation.sender_id = current_user.id
  @invitation.group_id = session[:group_id]
  if @invitation.save
  #  debugger
    if current_user != nil
      Mailer.invitation(@invitation).deliver_now
      flash[:notice] = "Thank you, invitation sent."
      redirect_to group_path(@invitation.group_id)
    else
      flash[:notice] = "Thank you, we will notify when we are ready."
      redirect_to root_path
    end
  else
    render :action => 'new'
  end
end

private
 
   def invitation_params
     params.require(:invitation).permit(:sender_id, :recipient_email, :token, :group_id )
   end
end
