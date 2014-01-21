class DepartmentsController < ApplicationController
  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end
  
  def create
    @department = Department.new(params[:department])    # Not the final implementation!
    if @department.save
	  flash[:success] = "Created department " + @department.name.upcase
	  Employee.create(department_id: @department.id, user_id: current_user.id, name: @department.name)
      redirect_to current_user
    else
      render 'new'
    end
  end
 
  def update
  end

end
