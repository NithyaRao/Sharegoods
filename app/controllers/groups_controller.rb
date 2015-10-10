class GroupsController < ApplicationController
  # layout 'main'
  
  def show
      @group = Group.find(params[:id]) 
      @admin = User.find(@group.owner_id) 
      @members =  @group.users
      session[:group_id] = @group.id
      @invitation = Invitation.new
      @items = Item.where(owner_id: @group.memberships)
      @categories = Category.all
      @item = Item.new
      @membership = Membership.find_by(user_id: session[:user_id], group_id: @group.id)  
     authorize @group
      #debugger
      # change the User.all to new many-many table 

    #  @member = user.new
  end

  def new
     @group = Group.new
     @user = User.find(current_user.id)
     session[:user_id] = @user.id
     @invitation = Invitation.new
     @membergroup = @user.groups
     authorize @group
    
  end

  def create
    #debugger
    @user = User.find(current_user.id)
    session[:user_id] = @user.id 
    if params[:selgroup] == "1" || params[:submit] == "Log In"
      @group = Group.find(params[:group][:id])
        if @group
       flash[:notice] = "Welcome to the #{@group.name} Group"
       redirect_to [@group]
      end
    else 
      @group = Group.new(group_params)
      @group.owner_id = @user.id
      authorize @group
      if @group.save 
         flash[:notice] = "Group was created succesfully"
         redirect_to [@group]
      else
         flash[:error] = "There was an error creating the group. Please try again."
         #redirect_to new_group_path
         @user = User.find(current_user.id)
         @invitation = Invitation.new
         @membergroup = @user.groups
         render :new
      end 
    end
  end

 def getmembers
      @group = Group.find(session[:group_id]) 
      @admin = User.find(@group.owner_id) 
      @members =  @group.users
      @invitations = Invitation.all
      @invitation = Invitation.new
     # authorize @group
      respond_to do |format|
        format.html
        format.js
     end
  end

 private
 
   def group_params
     params.require(:group).permit(:name, :description, :owner_id)
   end
end
