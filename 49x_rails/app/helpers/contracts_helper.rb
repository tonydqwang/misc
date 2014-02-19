module ContractsHelper

  def getUserContract (user)
    # restriction = Restriction.scoped(:conditions => ["user_id == @user.id"])
	# restriction = Restriction.where(user_id: user.id)
	
	depart_id = (Department.find_by_name(session[:dept_name].downcase)).id
	
	employee = (Employee.where(user_id: user.id).where(department_id: depart_id))
	
	for record in employee do
	  employeeid = record.id
	end
	
	# @employee_id = Employee.scoped(:conditions => ["department_id == depart_id"])
	
	
	@contract_recs = Contract.where(employee_id: employeeid)
	
	if @contract_recs == []
	  @contract_msgs = "You do not have any contract at this point"
	end
  end

end
