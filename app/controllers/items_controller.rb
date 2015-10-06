class ItemsController < ApplicationController
  def index
    #debugger
    @group = Group.find(session[:group_id])
    @items = Item.where(owner_id: @group.memberships)
    @categories = Category.all
  end

  def show
     @item = Item.find(params[:id])
  end

  def new
    debugger
    @item = Item.new
  end

  def create
       @item = Item.new(item_params)
       @group = Group.find(session[:group_id])
  
       @item.owner_id = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id]).id
       debugger
   
     if @item.save 
         flash[:notice] = "Item was created succesfully"
         redirect_to :back
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the Item. Please try again."
         render :new
     end 

    #  respond_to do |format|
   #     format.html
     #   format.js
     # end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update_attributes(item_params)
       flash[:notice] = "Item updated"
       redirect_to items_path
     else
       flash[:error] = "Invalid Item information"
       redirect_to edit_item_path
     end
  end

  def from_category
    #debugger
    @group = Group.find(session[:group_id])
    @items = Item.where(owner_id: @group.memberships)
    @selected = @items.where(category_id: params[:category_id]).order('available_at ASC')
  
    respond_to do |format|
        format.js
    end
  end

  def shareitems_requests
    #debugger
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @sharerequests = Request.where(item_id: Item.where(owner_id: @membership)).order('requesting_at DESC')
     
    respond_to do |format|
        format.js
    end
  end


 def accept_request
  @item = Item.find(params[:item_id])
  debugger
  if @item.update_attributes(available: !params[:checked])
    # ... update successful
     flash[:notice] = "Item updated"
     redirect_to fetch_shareitems_path;
  else
    # ... update failed
     flash[:error] = "Could not update information"
      redirect_to fetch_shareitems_path;
  end
 end

  private
 
   def item_params
     params.require(:item).permit(:category_id, :name, :description, :owner_id, :avatar, :available_at, :comment, :available )
   end
end
