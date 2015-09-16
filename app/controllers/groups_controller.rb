class GroupsController < ApplicationController
  def show
      @group = Group.find(params[:id]) 
      @admin = User.find(@group.owner) 
      @members =  @group.users
     # debugger
      # change the User.all to new many-many table 

    #  @member = user.new
  end

  def new
     @group = Group.new
  end

  def create
   # debugger
    @user = User.find(current_user)
    @group = Group.new(group_params)
    @group.owner = @user.id
    if @group.save && @group.memberships.create(user_id: @group.owner, groupowner: true)
       flash[:notice] = "Group was created succesfully"
       redirect_to [@group]
    else
       flash[:error] = "There was an error creating the group. Please try again."
       render :new
    end 
 end

 def edit
 end

 private
 
   def group_params
     params.require(:group).permit(:name, :description, :owner, :avatar)
   end
end
