class AllfilesController < ApplicationController
  def show
    if params[:id] != nil
      @allfile = Allfile.find(params[:id])
	else
	  @allfile = Allfile.find((session[:user_file]).id)
	end
  end

  def new
    @allfile = Allfile.new
  end
  
  def create
    @allfile = Allfile.new(params[:allfile])    # Not the final implementation!
    if @allfile.save
      flash[:success] = "File uploaded"
	  session[:user_file] = @allfile
	  filename = @allfile.master_loadform
	  @path = "C:\\Tony\\sample_app\\public" + filename.to_s
	  parseMaster(@path)
      redirect_to @allfile
    else
      render 'new'
    end
  end
  
  def edit
    @allfile = Allfile.find((session[:user_file]).id)
  end
  
  def update
    @allfile = Allfile.find((session[:user_file]).id)
    if @allfile.update_attributes(params[:allfile])
	  if params[:allfile][:master_loadform]
		filename = @allfile.master_loadform

		@path = "C:\\Tony\\sample_app\\public" + filename.to_s
		parseMaster(@path)
	  end
      flash[:success] = "File updated"
      redirect_to @allfile
    else
      render 'edit'
    end
  end
	
	def activeDeptID
		dept_id = (Employee.find_by_user_id(
						(User.find_by_remember_token(
							cookies[:remember_token])
						).id)
					).department_id
		return dept_id
	end
	
	def parseMaster (fpath)
		#fpath = "C:\\Tony\\input_files\\Load Format.csv"
		file = File.open(fpath, 'r')
		year = 999999 # initializer, will be overwritten by parsed values
		month = 999999	# initializer, will be overwritten by parsed values

		dept_id = activeDeptID()
		temp = ""
		
		# cleanse database of previous months' records if they need to be overwritten
		
		#User - no action necessary
		
		Restriction.delete_all
		
		Staff.where(
			pool_id: Pool.select(:id).where(department_id: dept_id)
		).destroy_all
		
		#Job - no action necessary
		
		Jobpool.where(
			job_id: Job.select(:id).where(department_id: dept_id)
		).destroy_all
		
		Timetable.delete_all
		
		
		# Administrator Master Load Form,,,,
		# ,,,,
		# Year,2013,,,
		# Month,12,,,
		# ,,,,
		
		headerEnd = false
		while !headerEnd
			line = file.readline 
			if line.start_with?("Year")
				tokens = line.split(",");
				year = tokens[1].to_i
			elsif line.start_with?("Month")
				tokens = line.split(",");
				month = tokens[1].to_i
				headerEnd = true
			end
		end
		
		calendarBegin = DateTime.new(year,month,1)
		
		lines = Array.new
		count = 0
		while !file.eof?
			lines[count] = file.readline
			count = count + 1
		end
		
		#t1=Thread.new{
			c1 = 0
			while c1 < lines.size
				if lines[c1].start_with?("Staff List")
					c1 = c1 + 2 #skips column headers
					while !lines[c1].start_with? ",,,,"
						parseStaffListRow(calendarBegin, lines[c1])
						c1 = c1 + 1
					end
				end
				c1 = c1 + 1
			end
		#}
		
		#t2=Thread.new{
			c2 = 0
			while c2 < lines.size
				if lines[c2].start_with?("Shifts")
					c2 = c2 + 2 #skips column headers
					while !lines[c2].start_with? ",,,"
						#contents << "LINE:" + line + "END"
						parseScheduleRow(calendarBegin, lines[c2], temp)
						#tempTime = DateTime.iso8601(temp)
						c2 = c2 + 1
					end
				end
				c2 = c2 + 1
			end
		#}
		#t1.join
		#t2.join
		
		#session[:temp] = temp
	end

	def daysInMonth(year, month)
		result = 0
		daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		if month == 2 && Date.gregorian_leap?(year) 
			result = 29
		else 
			result = daysInMonth[month.to_i - 1]
		end
		return result
	end 
	
	# tables modified: pool, pooluser(staff), restriction
	def parseStaffListRow(calendarBegin, line)
		data = line.split(",")
		poolValues = data[0].split(" ")
		userName = data[1]
		email = data[2]    
		restrictions = data[3]
		reason = data[4]
		
		dept_id = activeDeptID()
		
		# sanitize open string input
		if reason.start_with?("V")
			reason = "V"
		elsif reason.start_with?("P")
			reason = "P"
		end		
		
		calYear = calendarBegin.strftime("%Y").to_i
		calMonth = calendarBegin.strftime("%m").to_i
	
		# in case admin gets user name wrong. Email is mandatory field
		userFound = User.where(User.arel_table[:name].matches(userName)).first
		if (userFound == nil)
			userFound = User.where(User.arel_table[:email].matches(email)).first
			if (userFound == nil) # if user doesn't exist, skip to next
				if email =~ /([a-zA-Z0-9]|[-.])+@[a-zA-Z0-9]+.[a-zA-Z]/ # !~ if not regex
					userFound = User.create(
							name: userName, 
							email: email, 
							password: "face2book@", 
							password_confirmation: "face2book@", 
							admin:false
					)
					Employee.create(	#new user in system, new employee
							department_id: dept_id,
							name: Department.find(dept_id).name,
							user_id: userFound.id
					)
				end
				#return 		# or UI to offer option for admin to create user
			end
		end
		
		calendarEnd = calendarBegin + daysInMonth(calYear, calMonth)
		contract = Contract.where(
			"employee_id = ?, begin_time >= ?, end_time <=?",
			Employee.where(department_id: dept_id, user_id: userFound.id), 
			calendarBegin, calendarEnd
		)
		if contract == nil
			#for testing, generates contracts for the month if user is new
			#remove for production because medical school students program block terminates
			emp_id = Employee.select(:id).where(user_id: userFound.id)
			Contract.create(begin_time: calendarBegin, end_time: calendarEnd, employee_id: emp_id)
					
			#return 		# user has no active contract for the month
			# UI must then prompt admin to create contract
		end
		
		# if pool doesn't exist, create the pool. Pool now exists
		# if user exists, then add user to pool
		poolValues.each { |p|
			poolFound = Pool.where(Pool.arel_table[:name].matches(p)).first
			if (poolFound == nil)
				newPool = Pool.create(name: p, department_id: dept_id)
				poolFound = newPool
			end
			# user exists, add to current pool
			Staff.create(pool_id: poolFound.id, user_id: userFound.id )
		} #end parsing each pool for current person
	
		if !restrictions.eql? ""
			#user << printRow("user",userID,userName,0,0,0,0)
			#users should be in the db already
	  
			restrictions.split(" ").each { |r|
				# determine if it's single date, range, or special repeat options
				if r =~ /[0-9]+-[0-9]+/
					range = r.split("-")
					fromDayValue = range[0].to_i
					toDayValue = range[1].to_i 
					from = DateTime.new(calYear, calMonth, fromDayValue)
					to = DateTime.new(calYear, calMonth, toDayValue)
					to = to + 1
					Restriction.create(user_id: userFound.id, begin_time: from, end_time: to, reason: reason, approve: false)
				elsif r.eql? "weekends"	
					days = daysInMonth(calYear, calMonth)
					curDay = DateTime.parse(calendarBegin.to_s)
					for i in 1..days
						nextDay = curDay + 1
						if curDay.strftime("%u").to_i >= 6
							Restriction.create(user_id: userFound.id, begin_time: curDay, end_time: nextDay, reason: reason, approve: false)
						end									
						curDay = curDay + 1
					end
				elsif r.eql? "unavailable"
					calendarEnd = calendarBegin + daysInMonth(calYear, calMonth)
					Restriction.create(user_id: userFound.id, begin_time: calendarBegin, end_time: calendarEnd, reason: reason, approve: false)
				elsif r =~ /[1-9]+/ #single day
					fromDayValue = r.to_i
					if (fromDayValue > daysInMonth(calYear, calMonth))
						# throw crazy exception here
						# return nil	 # nonsensical day
					end
					from = DateTime.new(calYear, calMonth, fromDayValue)
					to = from + 1
					Restriction.create(user_id: userFound.id, begin_time: from, end_time: to, reason: reason, approve: false)
				end											
			}
		end # end parsing user restrictions
    end # end parse staff list section

	# Tables inserted to: Timetable(shift), job, jobpool
	def parseScheduleRow(calendarBegin, line, temp)
		data = line.split(",")
		job = data[0]
		poolValues = data[1].split(" ")
		sTime = DateTime.iso8601(data[2])
		eTime = DateTime.parse(data[3])
		repeat = data[4].strip
		
		calYear = calendarBegin.strftime("%Y").to_i
		calMonth = calendarBegin.strftime("%m").to_i
		
		dept_id = (Employee.find_by_user_id(
						(User.find_by_remember_token(
							cookies[:remember_token])
						).id)
					).department_id
		startDayOfMonth = sTime.strftime("%d").to_i
	
		jobFound = Job.where(Job.arel_table[:name].matches(job)).first
		# create job is it doesn't exist
		if (nil == jobFound) # uber pro anti-hacking syntax
			jobFound = Job.create(name: job, in_hospital: true, department_id: dept_id)
			#temp << "Job     JobID: " + jobFound.id.to_s + " Job: " + job + "\n"
		end
		
		poolValues.each { |p|
			poolFound = Pool.where(Pool.arel_table[:name].matches(p)).first
			dept_id = (Employee.find_by_user_id(
						(User.find_by_remember_token(cookies[:remember_token])).id)
					).department_id
			if (nil == poolFound)
				poolFound = Pool.create(department_id: dept_id, name: p)
			end
			newJobPool = Jobpool.create(job_id: jobFound.id, pool_id: poolFound.id)
			#temp << "Jobpool     JobID: " + newJobPool.job_id.to_s + " PoolID: " + newJobPool.pool_id.to_s + "\n"
			# if pool doesn't exist
			# throw some msg here to let user know
			# there might be spelling mistake
		} #end parsing each pool for current person
		
		if repeat.eql? "daily"
			for d in startDayOfMonth..daysInMonth(calYear, calMonth)
				newShift = Timetable.create(job_id: jobFound.id, begin_time: sTime, end_time: eTime)
				#temp << "Timetable     job_id: " + newShift.job_id.to_s + " start: " + newShift.begin_time.to_s + " end_time: " + newShift.end_time.to_s
				sTime = sTime + 1
				eTime = eTime + 1
			end
		elsif repeat.eql? "weekly"
			d = startDayOfMonth
			while d <= daysInMonth(calYear, calMonth)
				newShift = Timetable.create(job_id: jobFound.id, begin_time: sTime, end_time: eTime)
				#temp << "Timetable     job_id: " + newShift.job_id.to_s + " start: " + newShift.begin_time.to_s + " end_time: " + newShift.end_time.to_s
				sTime = sTime + 7
				eTime = eTime + 7
				d = d + 7
			end
		elsif repeat.eql? "weekdays"
			for d in startDayOfMonth..daysInMonth(calYear, calMonth)
				if (!sTime.to_date.saturday? && !sTime.to_date.sunday?) 
					newShift = Timetable.create(job_id: jobFound.id, begin_time: sTime, end_time: eTime)
					#temp << "Timetable     job_id: " + newShift.job_id.to_s + " start: " + newShift.begin_time.to_s + " end_time: " + newShift.end_time.to_s
				end
				sTime = sTime + 1
				eTime = eTime + 1
			end	
		elsif repeat.eql? "weekends"
			for d in startDayOfMonth..daysInMonth(calYear, calMonth)
				if (sTime.to_date.saturday? || sTime.to_date.sunday?) 
					newShift = Timetable.create(job_id: jobFound.id, begin_time: sTime, end_time: eTime)
					#temp << "Timetable     job_id: " + newShift.job_id.to_s + " start: " + newShift.begin_time.to_s + " end_time: " + newShift.end_time.to_s	
				end
				sTime = sTime + 1
				eTime = eTime + 1
			end
		else
			newShift = Timetable.create(job_id: jobFound.id, begin_time: sTime, end_time: eTime)
			#temp << "Timetable     job_id: " + newShift.job_id.to_s + " start: " + newShift.begin_time.to_s + " end_time: " + newShift.end_time.to_s
		end	
	end	# end parse schedule section
end
