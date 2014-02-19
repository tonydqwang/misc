class DroidsController < ApplicationController
	skip_before_filter :user_logged_in
	skip_before_filter  :verify_authenticity_token
	#before_filter [:signin, :schedule]
	
	def user
		if "CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8=".eql? params[:key]
			if params[:cmd].eql? "signin"
				user = User.find_by_email(params[:session][:email].downcase)
				if user && user.authenticate(params[:session][:password])
					sign_in user
					render json: user
				else
				  render inline: "Invalid email/password combination"
				end
				#end signin
			elsif params[:cmd].eql? "create"
				newUser = User.create(
					name: params[:name],
					email: params[:email].downcase,
					admin: params[:admin]
				)
				error = newUser.errors.full_messages.to_s
				render inline: error
				#end create NOT WORKING CURRENTLY
			else
				render inline: "Invalid cmd"
			end
		else
			render inline: "Invalid key"
		end
	end
	
	def schedule
		if "CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8=".eql? params[:key]
			if params[:cmd].eql? "read"
				scheduleJSON = Event.where(
					"user_id = ? AND start_at >= ? AND end_at <=?",
					params[:user_id], 
					DateTime.parse(params[:start]),
					DateTime.parse(params[:end])
				)
				render json: scheduleJSON
			else
				render inline: "Invalid cmd"
			end
		else
			render inline: "Invalid key"
		end
	end
	
	def restriction
		if "CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8=".eql? params[:key]
			if params[:cmd].eql? "read"
				restrictJSON = Restriction.where(
					"user_id = ? AND begin_time <= ? AND end_time >=?",
					params[:user_id], 
					DateTime.parse(params[:end]),
					DateTime.parse(params[:start])					
				)
				render json: restrictJSON
				#end view
			elsif params[:cmd].eql? "create"
				newRestriction = Restriction.create(
					user_id: params[:user_id],
					begin_time: DateTime.parse(params[:start]),
					end_time: DateTime.parse(params[:end]),
					reason: params[:reason],
					approve: params[:approve]
				)
				error = newRestriction.errors.full_messages.to_s
				render inline: error
				#end add
			elsif params[:cmd].eql? "delete"
				deleted = Restriction.where(id: params[:id]).first
				error = "restriction of id = " + params[:id] + " not found"			
				if nil != deleted
					deleted = Restriction.destroy(params[:id])
					error = deleted.errors.full_messages.to_s
				end
				render inline: error
				#end delete
			elsif params[:cmd].eql? "update"
				record = Restriction.find_by_id(params[:id])
				error = "restriction of id = " + params[:id] + " not found"
				if nil != record
					error = ""
					if "NO_CHANGE" != params[:user_id]
						record.update_attributes(user_id: params[:user_id])
						error += record.errors.full_messages.to_s
					end	
					
					if "NO_CHANGE" != params[:start]
						record.update_attributes(begin_time: params[:start])
						error += record.errors.full_messages.to_s
					end
					
					if "NO_CHANGE" != params[:end]
						record.end_time = params[:end]
						error += record.errors.full_messages.to_s
					end
						
					if "NO_CHANGE" != params[:reason]
						record.reason = params[:reason]
						error += record.errors.full_messages.to_s
					end
					
					if "NO_CHANGE" != params[:approve]
						record.approve = params[:approve]
						error += record.errors.full_messages.to_s
					end
					render inline: error
				end
				#end update
			else
				render inline: "Invalid cmd"
			end
		else
			render inline: "Invalid key"
		end
	end
	
	def department
		if "CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8=".eql? params[:key]
			if params[:cmd].eql? "read"
				deptJSON = Department.all
				render json: deptJSON
			elsif params[:cmd].eql? "join"
				empFound = Employee.where(
					user_id: params[:user_id],
					department_id: params[:department_id]
				).first
				error = "employee of user_id = " + params[:user_id] 
				error += " in department_id " + params[:department_id] + " already exists"
				if nil == empFound
					deptFound = Department.where(id: params[:department_id]).first
					error = "department_id " + params[:department_id] + " doesn't exist"
					if nil != deptFound 
						newEmployee = Employee.create(
							user_id: params[:user_id], 
							department_id: deptFound.id,
							name: deptFound.name
						)
						error = newEmployee.errors.full_messages.to_s
					end
				end
				render inline: error
			elsif params[:cmd].eql? "leave"
				empFound = Employee.where(
					user_id: params[:user_id],
					department_id: params[:department_id]
				).first
				error = "employee of user_id = " + params[:user_id] 
				error += " in department_id " + params[:department_id] + " doesn't exist"
				if nil != empFound
					deleted = Employee.destroy(empFound.id)
					error = deleted.errors.full_messages.to_s
				end
				render inline: error
			else
				render inline: "Invalid cmd"
			end
		else
			render inline: "Invalid key"
		end
	end
	
	def pool
		if "CNo3TfHI5GzfT3j+AEbREXO5LrZhHeFy3X64JVa07z8=".eql? params[:key]
			if params[:cmd].eql? "read"
				poolJSON = Pool.all
				render json: poolJSON
			elsif params[:cmd].eql? "join"
				staffFound = Staff.where(
					user_id: params[:user_id],
					pool_id: params[:pool_id]
				).first
				error = "staff of id = " + params[:user_id] 
				error += " in pool_id " + params[:pool_id] + " already exists"
				if nil == staffFound
					poolFound = Pool.where(id: params[:pool_id]).first
					error = "department_id " + params[:pool_id] + " doesn't exist"
					if nil != poolFound 
						newStaff = Staff.create(
							user_id: params[:user_id], 
							pool_id: poolFound.id,
							name: poolFound.name
						)
						error = newStaff.errors.full_messages.to_s
					end
				end
				render inline: error
			elsif params[:cmd].eql? "leave"
				staffFound = Staff.where(
					user_id: params[:user_id],
					department_id: params[:department_id]
				).first
				error = "employee of user_id = " + params[:user_id] 
				error += " in department_id " + params[:department_id] + " doesn't exist"
				if nil != staffFound
					deleted = Staff.destroy(empFound.id)
					error = deleted.errors.full_messages.to_s
				end
				render inline: error
			else
				render inline: "Invalid cmd"
			end
		else
			render inline: "Invalid key"
		end
	end
end