class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :user_logged_in
  
  def user_logged_in
  if !current_user
  flash[:log_in_error]  = "Please Log in to view other pages"
  redirect_to root_path
  end
end
end
