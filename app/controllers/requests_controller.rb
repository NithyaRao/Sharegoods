class RequestsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @request = Request.new
    @item = Item.find(params[:item_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
      @request= Request.new(request_params)
       @item = Item.find(params[:item_id])
       @request.item_id = @item.id
       @request.requestor_id = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id]).id
   ### send Mail to owner  #####
       debugger
   
     if @request.save 
         flash[:notice] = "Request was created succesfully"
         redirect_to :back
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the Request. Please try again."
         render :new
     end 
  end 

  def edit
  end
  private
 
   def request_params
     params.require(:request).permit(:requestor_id, :item_id, :description, :requesting_at, :returning_at )
   end
end
