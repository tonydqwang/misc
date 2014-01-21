namespace :td do

	desc "Fill database with test users"
	task tdp_users: :environment do
		
		# clear database of tables to be modified
		User.delete_all
		Department.delete_all
		Employee.delete_all	
		Contract.delete_all
	
		department_name = "KGH-PSYC"
		pw = "face2book@"
		emailExt = "@49x.com"
		
		email = "OS#{emailExt}"
		OS = User.create!(name: "OS Dude",
                 email: email,
                 password: pw,
                 password_confirmation: pw)
		OS.toggle!(:admin)
		
		department = Department.create!(name: department_name, user_id: OS.id)	
		employee = Employee.create!(name: department.name, department_id: department.id, user_id: OS.id)
		contract = Contract.create!(employee_id: employee.id, begin_time:DateTime.new(2000), end_time:DateTime.new(3000))
		
		40.times do |n|
			name  = "user#{n+1} Dude"
			email = "user#{n+1}#{emailExt}"
			user_poplulate = User.create!(
				name: name,
                email: email,
                password: pw,
                password_confirmation: pw
			)
			employees = Employee.create!(name: department.name, department_id: department.id, user_id: user_poplulate.id)
			contracts = Contract.create!(employee_id: employees.id, begin_time: DateTime.new(2013), end_time: DateTime.new(2015))
		end		
	end
end