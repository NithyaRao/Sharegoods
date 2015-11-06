class InvitationsController < ApplicationController
before_action :auth_user

def new
  #debugger
  @invitation = Invitation.new
  authorize @invitation

end

def create
 # @invitation = Invitation.new(invitation_params)
   @invitation = Invitation.find_or_initialize_by(invitation_params)
  # debugger
  @invitations = Invitation.where(group_id: session[:group_id])
  @new_invitation = Invitation.new
  @invitation.sender_id = current_user.memberships.find_by(group_id: session[:group_id]).id
  @invitation.group_id = session[:group_id]
  authorize @invitation
 # debugger
  if @invitation.save 
  # debugger
    if current_user != nil
      MemberNotifier.invitation(@invitation, current_user.email).deliver_now
      flash.now[:notice] = "Thank you, invitation sent."
      @group = Group.find(session[:group_id])
    else
      flash[:notice] = "Thank you, we will notify when we are ready."
    end
  else
    flash[:error] = "There was an error creating the Invitation. Please try again."
    @group = Group.find(session[:group_id])
  end

  respond_to do |format|
    format.html
    format.js
  end
end

private
 
   def invitation_params
     params.require(:invitation).permit(:sender_id, :recipient_email, :token, :group_id )
   end
end
