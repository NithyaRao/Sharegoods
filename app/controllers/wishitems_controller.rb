class WishitemsController < ApplicationController
  def index
    debugger
    @group = Group.find(session[:group_id]) 
    @wishitems = Wishitem.where(requestor_id: @group.memberships)
    @categories = Category.all
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
       @wishitem = Wishtem.new(wishitem_params)
       @group = Group.find(session[:group_id])
  
       @wishitem.requestor_id = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id]).id
       #debugger
   
     if @wishitem.save 
         flash[:notice] = "WishItem was created succesfully"
         redirect_to :back
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the wishitem. Please try again."
         @group = Group.find(session[:group_id])
         render :new
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

  def add_to_items
    @group = Group.find(session[:group_id]) 
    @wishitems = Wishitem.where(requestor_id: @group.memberships)
    @categories = Category.all
  end

  private
 
   def wishitem_params
     params.require(:wishitem).permit(:category_id, :name, :description, :requestor_id, :requesting_at )
   end
end
