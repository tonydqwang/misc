class JobpoolsController < ApplicationController
        def new
                @jobpool = Jobpool.new
        end
  
        def create
                @pool = Pool.where("id IN (?)", params[:jobpool][:pool_id])

                for current_pool in @pool do
                        @jobpool = Jobpool.new(pool_id: current_pool.id, job_id: params[:jobpool][:job_id])
                        if @jobpool.save
                          flash[:success] = "New pool created!"
						  redirect_to @jobpool
                        else
						  render 'new'
                        end
                end

        end
		
  def update
    @jobpool = Jobpool.find_by_id(params[:id])
    
  	if params["Update Jobpool"]
	  @jobpool = Jobpool.find_by_id(params[:jobpool][:my_variable])
	  session[:jobpool] = @jobpool
	  redirect_to edit_jobpool_path
	
    elsif @jobpool.update_attributes(job_id: params[:jobpool][:job_id], pool_id: params[:jobpool][:pool_id][0])
      flash[:success] = "jobpool updated!"

      redirect_to @jobpool
    else
      render 'edit'
    end
  end
		


  def show
  	session[:jobpool] = nil
  end
  
  def edit
	@jobpool = session[:jobpool]
  end
  
  def destroy
    Jobpool.find(params[:id]).destroy
    flash[:success] = "jobpool deleted"
    redirect_to showjobpool_path
  end
  
end