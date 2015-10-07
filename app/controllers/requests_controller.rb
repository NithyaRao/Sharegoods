class RequestsController < ApplicationController
  def index
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @requests = Request.where(item_id: Item.where(owner_id: @membership)).order('requesting_at DESC')
     
    respond_to do |format|
        format.js
        format.html
    end
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
         redirect_to :back #groups_path(session[:group_id])
      #   redirect_to new_group_item_path(session[:group_id])
     else
         flash[:error] = "There was an error creating the Request. Please try again."
         @item = Item.find(params[:item_id])
         render :new
     end 
  end 

# Requests for the logged in users items 
  def sharerequests
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @requests = Request.where(item_id: Item.where(owner_id: @membership)).order('requesting_at DESC')
     
    respond_to do |format|
        format.js
        format.html
    end
  end

  def accept_request
  @request = Request.find(params[:request_id])
  debugger
  if @request.update_attributes(accepted: params[:checked])
      redirect_to fetch_sharerequests_path(), notice: "Request accepted "
  else
     redirect_to fetch_sharerequests_path(), error: "Request to accept denied "
  end
 end

 

  private
 
   def request_params
     params.require(:request).permit(:requestor_id, :item_id, :description, :requesting_at, :returning_at )
   end
end
