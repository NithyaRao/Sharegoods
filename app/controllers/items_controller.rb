class ItemsController < ApplicationController
  def index
    #debugger
    @group = Group.find(session[:group_id])
    @items = Item.where(owner_id: @group.memberships)
    @categories = Category.all
    authorize @items
  end

  def show
     @item = Item.find(params[:id])
     authorize @item
  end

  def new
    @item = Item.new
    @group = Group.find(session[:group_id])
    #debugger
    authorize @item
    respond_to do |format|
      format.html
      format.js
     end
  end

  def create
    @item = Item.new(item_params)
    @group = Group.find(session[:group_id])
    debugger  
    @item.owner_id = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id]).id
    @item.available_at =  Date.strptime(item_params[:available_at], '%m/%d/%Y').to_date if item_params[:available_at]
    @item.available = true if @item.available_at
       #debugger
    authorize @item
    if @item.save 
      flash[:notice] = "Item was created succesfully"
      redirect_to :back
      #   redirect_to new_group_item_path(session[:group_id])
    else
      flash[:error] = "There was an error creating the Item. Please try again."
      @group = Group.find(session[:group_id])
         # check for controller if wishitem then redirect_to wishitem page
      render :new
    end 

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    authorize @item
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
    authorize @selected, :index?
    respond_to do |format|
      format.js
      format.html
    end
  end


  private
 
  def item_params
    params.require(:item).permit(:category_id, :name, :description, :owner_id, :available_at, :comment, :available, :avatar)
  end
end
