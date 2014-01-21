class PoolsController < ApplicationController
  def new
	@pool = Pool.new
  end
  
  def create

    @pool = Pool.new(params[:pool])
    if @pool.save
      flash[:success] = "New pool created!"
      redirect_to @pool
    else
      render 'new'
    end
  end
  
  def show
  	session[:pool] = nil
  end
  
  def edit
	@pool = session[:pool]
  end
  
  def destroy
    Pool.find(params[:id]).destroy
    flash[:success] = "pool deleted"
    redirect_to showpool_path
  end
  
  def update
  
    @pool = Pool.find_by_id(params[:id])
    
  	if params["Update Pool"]
	  @pool = Pool.find_by_id(params[:pool][:my_variable])
	  session[:pool] = @pool
	  redirect_to edit_pool_path
	
    elsif @pool.update_attributes(params[:pool])
      flash[:success] = "pool updated!"

      redirect_to @pool
    else
      render 'edit'
    end
  end
  
end
