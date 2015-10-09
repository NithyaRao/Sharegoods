class WishitemsController < ApplicationController
  def index
    #debugger
    @group = Group.find(session[:group_id]) 
    @wishitems = Wishitem.where(requestor_id: @group.memberships)
    @categories = Category.all
    @wishitem = Wishitem.new
  end

  def show
     @wishitem = Wishitem.find(params[:wish_item_id])
  end

  def new
    @wishitem = Wishitem.new
    @group = Group.find(session[:group_id])
    #debugger
    respond_to do |format|
        format.html
        format.js
     end
  end

  def create
       #  debugger
       @wishitem = Wishitem.new(wishitem_params)
       @group = Group.find(session[:group_id])
       @new_wishitem = Wishitem.new
  
       @wishitem.requestor_id = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id]).id
     
   
     if @wishitem.save 
         flash[:notice] = "WishItem was created succesfully"
       #  debugger
       #   redirect_to group_wishitems_path(@group.id)
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the wishitem. Please try again."
         @group = Group.find(session[:group_id])
      #   render  group_wishitems_path(group_id: @group.id)
     end 

     respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @wishitem = Wishitem.find(params[:id])
  end

  def update
    if @wishitem.update_attributes(wishitem_params)
       flash[:notice] = "WishItem updated"
       redirect_to wishitems_path
     else
       flash[:error] = "Invalid WishItem information"
       redirect_to edit_wishitem_path
     end
  end

  def member_has_wishitem
       @wishitem = Wishitem.find(params[:wishitem_id])
       @group = Group.find(session[:group_id]) 
       @member = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
  end

  def add_to_items
      @wishitem = Wishitem.find(params[:wishitem_id])
      @group = Group.find(session[:group_id]) 
      @item = Item.new 
      @item.assign_attributes(category_id: @wishitem.category_id, name: @wishitem.name, description: @wishitem.description, owner_id: @member, available_at: Time.now, available: 'true' )
      if @item.save 
         @wishitem.destroy
         flash[:notice] = "Item was created succesfully from wishitem"
        # debugger
         redirect_to group_wishitems_path(group_id: @group.id)
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the item from wishitem. Please try again."
         @group = Group.find(session[:group_id])
         @wishitem = Wishitem.find(params[:wishitem_id])
         render member_has_wishitem_path(@wishitem.id)
     end   
      
  end

  private
 
   def wishitem_params
    # debugger
     params.require(:wishitem).permit(:category_id, :name, :description, :requestor_id, :requesting_at )
   end
end
