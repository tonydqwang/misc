class RestrictionsController < ApplicationController
  def show
    @restriction = Restriction.find_by_user_id(params[:id])
	session[:restriction] = nil
  end

  def new
    @restriction = Restriction.new
  end
  
  def create

    @restriction = Restriction.new(params[:restriction])
	if current_user.admin?
		@restriction.approve = true # Not the final implementation!
	else
		@restriction.approve = false
	end
    if @restriction.save
      flash[:success] = "New restriction created!"
      redirect_to @restriction
    else
      render 'new'
    end
  end
  
  def edit
    #if session[:restriction]
    #  @restriction = Restriction.find_by_id(session[:restriction])
	#end
	
	#if params["Update Restriction"]
	#  @restriction = Restriction.find_by_id(params[:my_variable][:value])
	#end
	#my_variable = params[:my_variable]
	#@restriction = Restriction.find_by_id(my_variable)
	

	@restriction = session[:restriction]

  end
  
  def update
  
    @restriction = Restriction.find_by_id(params[:id])
    
  	if params["Update Restriction"]
	  @restriction = Restriction.find_by_id(params[:restriction][:my_variable])
	  session[:restriction] = @restriction
	  redirect_to edit_restriction_path
	
    elsif @restriction.update_attributes(params[:restriction])
      flash[:success] = "restriction updated!"

      redirect_to @restriction
    else
      render 'edit'
    end
  end
  
  def destroy
    Restriction.find(params[:id]).destroy
    flash[:success] = "restriction deleted"
    redirect_to current_user
  end   
end
