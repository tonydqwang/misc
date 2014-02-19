class StaticPagesController < ApplicationController
  
  skip_before_filter :user_logged_in, only: [:home]
  
  def home
	if current_user
	redirect_to current_user
	end

  end

  def help
  end
  
  def about
  end
  
  def contact
  end

end
