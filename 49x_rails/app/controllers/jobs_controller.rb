class JobsController < ApplicationController
  def new
    @job = Job.new
  end
  
  def show
  	session[:job] = nil
  end
	
  def create
    @job = Job.new(params[:job])
	if @job.save
	  flash[:success] = "New Job created!"
	  redirect_to @job
	else
	  render 'new'
	end
  end
  
  def edit
	@job = session[:job]
  end
  
  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "job deleted"
    redirect_to showjob_path
  end
  
  def update
  
    @job = Job.find_by_id(params[:id])
    
  	if params["Update Job"]
	  @job = Job.find_by_id(params[:job][:my_variable])
	  session[:job] = @job
	  redirect_to edit_job_path
	
    elsif @job.update_attributes(params[:job])
      flash[:success] = "job updated!"

      redirect_to @job
    else
      render 'edit'
    end
  end

def tester
@job = Job.new
end
def testing
session[:dept_name] = params[:employee]
session[:current_job_id] = nil
redirect_to '/jobs/tester'
end
def testing2
session[:current_job_id] = params[:id]
redirect_to '/jobs/tester'
end
def testing3
session[:current_job_id] = params[:employee]
redirect_to '/jobs/tester'
end
end
