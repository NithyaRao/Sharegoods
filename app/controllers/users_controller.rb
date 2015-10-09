class UsersController < ApplicationController
   before_action :authenticate_user!, except: [:show]
 
   def index
    # debugger
    #  @users = User.top_rated.paginate(page: params[:page], per_page: 10)
   end

   def show
     # debugger
      @user = User.find(params[:id])
   # @posts = @user.posts.visible_to(current_user)
    end
   
  # def edit
  #   debugger
  #     @user = User.find(params[:id])
  #     # error unless @user == current_user
  #     @user.build_address if @user.address.nil? 
  #   debugger
  # end
   def update
    # debugger
     @user = current_user
    # @user.build_address if @user.address.nil?
     if @user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
   end

   
   private
 
   def user_params
     params.require(:user).permit(:name, address_attributes: [:id, :address1, :address2, :city, :state, :zip, :home_phone, :cell_phone])
   end
 end