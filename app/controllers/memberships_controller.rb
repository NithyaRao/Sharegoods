class MembershipsController < ApplicationController
  def new
     @membership = Membership.new
  end

  def create
    debugger
    @user = User.find(current_user)
    @group = Group.find(params[:membership][:group_id])
     if @group
       flash[:notice] = "Welcome to the Group"
       redirect_to [@group]
    else 
       if @group.memberships.create(user_id: @user)
          flash[:notice] = "Group was created succesfully"
          redirect_to [@group]
       else
          flash[:error] = "There was an error creating the group. Please try again."
          render :new
       end   
    end 
  end
end