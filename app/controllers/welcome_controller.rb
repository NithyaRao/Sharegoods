class WelcomeController < ApplicationController
  def index
    if current_user 
       redirect_to welcome_about_path 
    end
  end

  def about
  end
end
