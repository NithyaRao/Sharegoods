class GroupsController < ApplicationController
  def show
      @group = Group.find(params[:id]) 
      @admin = User.find(@group.owner) 
      @members =  @group.users
      session[:group_id] = @group.id
      @invitation = Invitation.new
     # debugger
      # change the User.all to new many-many table 

    #  @member = user.new
  end

  def new
     @group = Group.new
     @user = User.find(current_user.id)
     @invitation = Invitation.new
     @membergroup = @user.groups
  end

  def create
    debugger
    @user = User.find(current_user)
    if params[:selgroup] == "1" || params[:submit] == "Log In"
      @group = Group.find(params[:group][:id])
      if @group
       flash[:notice] = "Welcome to the #{@group.name} Group"
       redirect_to [@group]
      end
    else 
      @group = Group.new(group_params)
      @group.owner = @user.id
      if @group.save 
         flash[:notice] = "Group was created succesfully"
         redirect_to [@group]
      else
         flash[:error] = "There was an error creating the group. Please try again."
         render :new
      end 
    end
  end

 def edit
 end

 private
 
   def group_params
     params.require(:group).permit(:name, :description, :owner)
   end
end
