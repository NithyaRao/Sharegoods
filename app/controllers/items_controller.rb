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
    @selected = @items.where(:category_id => params[:category_id])
    respond_to do |format|
        format.js
    end
  end

  private
 
   def item_params
     params.require(:item).permit(:category_id, :name, :description, :owner_id, :avatar, :requestor_id, :available_at, :requesting_at, :returning_at, :comment, :available )
   end
end
