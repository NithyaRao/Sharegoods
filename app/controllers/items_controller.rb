class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
     @item = Item.find(params[:id])
  end

  def new
    @item = Item.new(item_params)
    @owner_id = current_user.id 
    @category_id = Category.find(:category_id)
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
  private
 
   def items_params
     params.require(:item).permit(:category_id, :name, :description, :owner_id, :avatar, :requestor_id, :available_at, :requesting_at, :returning_at, :comment, :available )
   end
end
