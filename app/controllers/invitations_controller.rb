class InvitationsController < ApplicationController

def index
  #debugger
  @invitations = Invitation.all
  authorize @invitations

end

def new
  #debugger
  @invitation = Invitation.new
  authorize @invitation

end

def create
  @invitation = Invitation.new(invitation_params)

  @invitation.sender_id = current_user.id
  @invitation.group_id = session[:group_id]
  authorize @invitation
  debugger
  if @invitation.save
  # debugger
    if current_user != nil
      Mailer.invitation(@invitation).deliver_now
      flash.now[:notice] = "Thank you, invitation sent."
      @group = Group.find(session[:group_id])
    #  redirect_to fetch_groupmembers_path(session[:group_id])
      redirect_to :back
    else
      flash[:notice] = "Thank you, we will notify when we are ready."
      redirect_to root_path
    end
  else
     @group = Group.find(session[:group_id])
    render fetch_groupmembers_path(session[:group_id])
  end
end

private
 
   def invitation_params
     params.require(:invitation).permit(:sender_id, :recipient_email, :token, :group_id )
   end
end
