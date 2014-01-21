class UsersController < ApplicationController
  
  skip_before_filter :user_logged_in, only: [:new, :create]
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,   only: :destroy
  
  
  def show

    @user = User.find(params[:id])
	current_user

  end

  def new
    @user = User.new
  end
  
  def create
	
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Scheduler! Please start by create/join a pool."
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def index
	@users = User.paginate(page: params[:page])
  end
  
  def edit
  end
  
  def update
    if params["Change Department"]
	  session[:dept_name] = params[:employee][:name]
      redirect_to @user
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end   
  
  def set_session
  
  end
  
  private
    def signed_in_user
	  unless signed_in?
	    store_location
		redirect_to signin_path, notice: "Please sign in."
	  end
    end
	
	def correct_user
	  @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
	end
	
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end