class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
    @departments = Department.where(:name => params[:name])
	if params[:all] == "yes"
	  @departments = Department.all
	end
  end
  
  def create
    @employee = Employee.new    # Not the final implementation!
	@department = Department.find(params[:my_variable])
	@employee.name = Department.find(params[:my_variable]).name
	@employee.department_id = params[:my_variable]
	@employee.user_id = current_user.id
	if params[:yes]
		@employee.destroy
		redirect_to current_user
    elsif @employee.save
	  flash[:success] = "Joined department " + @employee.name.upcase
      redirect_to current_user
    else
      render 'find'
    end
  end
  
  def destroy
	@employee = Employee.where(:department_id => params[:id], :user_id => current_user.id)
	if !@employee.empty?
		@employee = @employee.first
		@employee.destroy
		flash[:success] = "Left Department"
		redirect_to current_user
	else
		flash[:failure] = "Couldn't leave Department"
		redirect_to current_user
	end
  end   
end