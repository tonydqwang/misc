class ContractsController < ApplicationController
  def show
	session[:contract] = nil
  end

  def new
    @contract = Contract.new
  end
  
  def create

    @contract = Contract.new(params[:contract])    # Not the final implementation!
    if @contract.save
      flash[:success] = "New contract created!"
      redirect_to @contract
    else
      render 'new'
    end
  end
  
  def destroy
    Contract.find(params[:id]).destroy
    flash[:success] = "contract deleted"
    redirect_to showcontract_path
  end  
  
  def edit
	@contract = session[:contract]
  end
  
  def update
  
    @contract = Contract.find_by_id(params[:id])
    
  	if params["Update Contract"]
	  @contract = Contract.find_by_id(params[:contract][:my_variable])
	  session[:contract] = @contract
	  redirect_to edit_contract_path
	
    elsif @contract.update_attributes(params[:contract])
      flash[:success] = "contract updated!"

      redirect_to @contract
    else
      render 'edit'
    end
  end
end
