class WishitemsController < ApplicationController
  before_action :auth_user

  def index
    @group = Group.find(session[:group_id]) 
    @wishitems = Wishitem.where(requestor_id: @group.memberships)
    @categories = Category.all
    @wishitem = Wishitem.new

    authorize @wishitems
    respond_to do |format|
        format.html
        format.js
     end
  end

  def show
     @wishitem = Wishitem.find(params[:wish_item_id])
     authorize @wishitem
  end

  def new
    @wishitem = Wishitem.new
    @group = Group.find(session[:group_id])
    authorize @wishitem
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
       @wishitem.requesting_at = Date.strptime(wishitem_params[:requesting_at], '%m/%d/%Y').to_date if wishitem_params[:requesting_at]
  
       authorize @wishitem
   
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
    authorize @wishitem
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
      @member = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
      @requestor = User.find(Membership.find_by(@wishitem.requestor_id).user_id)
      @item = Item.new 
      @item.assign_attributes(category_id: @wishitem.category_id, name: @wishitem.name, description: @wishitem.description, owner_id: @member, available_at: Time.now, available: 'true' )
      authorize @item, :create?
      if @item.save 
         @wishitem.destroy
         return render text: "successfully created", status: 200
         # flash[:notice] = "Item was created succesfully from wishitem"
         MemberNotifier.notify_requestor(@wishitem, @requestor.email, @requestor.name, @group.name, current_user.email).deliver_now
   
         redirect_to group_wishitems_path(@group.id)
        # redirect_to :back
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
