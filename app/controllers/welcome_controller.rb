class WelcomeController < ApplicationController
  def index
    if current_user 
      redirect_to groups_path 
    end
  end

  def about
  end
end
