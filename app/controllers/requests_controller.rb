class RequestsController < ApplicationController
  def index
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @requests = Request.where(item_id: Item.where(owner_id: @membership)).order('requesting_at DESC')
     authorize @requests
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @request = Request.new
    @item = Item.find(params[:item_id])
    authorize @request
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
    @request.requesting_at = Date.strptime(request_params[:requesting_at], '%m/%d/%Y').to_date if request_params[:requesting_at]
    @request.returning_at = Date.strptime(request_params[:returning_at], '%m/%d/%Y').to_date if request_params[:returning_at]
   ### send Mail to owner  #####
      # debugger
    authorize @request
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

# Get all requests for the logged in users items 
  def sharerequests
    @group = Group.find(session[:group_id])
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @requests = Request.where(item_id: Item.where(owner_id: @membership)).order('requesting_at DESC')
    authorize @requests, :index?
    respond_to do |format|
      format.js
      format.html
    end
  end
 # get all logged in users request for others items

   def memberrequests
    @group = Group.find(session[:group_id])
    @membership = Membership.find_by(user_id: session[:user_id], group_id: session[:group_id])
    @requests = Request.where(requestor_id: @membership).order('requesting_at DESC')
    authorize @requests, :index?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def accept_request
    @request = Request.find(params[:request_id])
    @requestor= User.find(Membership.find_by(@request.requestor_id).user_id)
    @group = Group.find(session[:group_id])
   # debugger
    authorize @request, :update?
    if @request.update_attributes(accepted: params[:checked])
      #send email to requestor 
       MemberNotifier.accept_request(@request, @requestor.email, @requestor.name, @group.name, current_user.email).deliver_now
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
