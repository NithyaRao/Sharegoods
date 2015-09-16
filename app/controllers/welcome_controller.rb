class WelcomeController < ApplicationController
  def index
    if current_user 
      redirect_to new_group_path 
    end
  end

  def about
  end
end
