class StaffsController < ApplicationController
  def new
    @staff = Staff.new
  end
  
  def show
  	session[:staff] = nil
  end
  
  def destroy
    Staff.find(params[:id]).destroy
    flash[:success] = "Left pool"
    redirect_to showstaff_path
  end
  
  def create

    @staff = Staff.new(params[:staff])
    if @staff.save
      flash[:success] = "Joined pool!"
      redirect_to @staff
    else
      flash[:success] = "Failed to join!"
      redirect_to showstaff_path
    end
  end
end
