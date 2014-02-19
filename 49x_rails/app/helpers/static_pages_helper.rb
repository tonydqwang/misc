require "net/http"
require "uri"

module StaticPagesHelper

	
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
	
	def exportEvents
		curUser = User.find_by_remember_token(cookies[:remember_token])
		dept_id = (Employee.find_by_user_id((curUser).id)).department_id
		
		beginYear = 2013	#session[:year]
		beginMonth = 12		#session[:month]
		beginDate = DateTime.new(beginYear, beginMonth)
		endDate = beginDate + daysInMonth(beginYear, beginMonth)
		
		csvString = CSV.generate do |csv|
			events = Event.where(
				"department_id = ? AND start_at >= ? AND end_at <= ?",
				dept_id, beginDate, endDate				
			)
				
			events.each { |e| 
				pools = Pool.where(id: Jobpool.select(:pool_id).where(
					job_id: e.job_id)
				)
				count = 0
				poolCSV = ""
				pools.each { |p|
					if count > 0
						poolCSV << " "
					end
					count = count + 1
					poolCSV << p.name
				}
				csv << [e.job_id, poolCSV, e.start_at, e.end_at]
			}
		end
		
		return csvString
	end

	
	def exportMaster
		fpath = "C:\\Tony\\output_files\\LoadFormat.csv"
		file = File.open(fpath, "w")
		content = "Administrator Master Load Form\n,,,,\n"
		
		beginYear = 2013 #session[:year]
		beginMonth = 12 #session[:month]
		beginDate = DateTime.new(beginYear,beginMonth)
		endDate = beginDate + daysInMonth(beginYear, beginMonth)
		
		content << "Year," + beginYear.to_s + ",,,\nMonth," + beginMonth.to_s + ",,,\n,,,,\n"
		
		curUser = User.find_by_remember_token(cookies[:remember_token])
		dept_id = (Employee.find_by_user_id((curUser).id)).department_id
		
		if curUser.admin != true
			return "Permission Denied"
		end
		
		exportStaffList(content, dept_id, beginDate, endDate)
		content << ",,,,\n"
		exportShifts(content, dept_id, beginDate, endDate)
		content << ",,,,\n"
		exportInstructions(content)
		
		file.write(content)
		file.close
		return content
	end
	
	def exportStaffList(content, dept_id, beginDate, endDate)
		content << "Staff List\nPool,User Name,User Email,Restrictions,Reason\n"
		users = User.where(
					id: Employee.select(:user_id).where(
						department_id: dept_id,
						id: Contract.select(:employee_id).where(
							"begin_time <= ? AND end_time >= ?", 
							beginDate, endDate)
					)
				)	
		validContracts = Contract.select(:employee_id).where(
							"begin_time <= ? AND end_time >= ?", 
							beginDate, endDate)
		contract = Contract.first
		#content << contract.begin_time.iso8601 + "\n"
		#content << validContracts.count.to_s + "\n"
		
		users.each { |u|
			pools = Pool.where(
				department_id: dept_id,
				id: Staff.select(:pool_id).where(user_id: u.id)
			)
			count = 0
			poolCSV = ""
			pools.each { |p|
				if count > 0
					poolCSV << " "
				end
				count = count + 1
				poolCSV << p.name
			}
			# user name and email address contained in u object		
			restrictionsV = Restriction.where(
				"user_id = ? AND begin_time <= ? AND end_time >= ? AND reason = ?", 
				u.id, endDate, beginDate, "V"
			)
			
			restrictionsR = Restriction.where(
				"user_id = ? AND begin_time <= ? AND end_time >= ? AND reason = ?", 
				u.id, endDate, beginDate, "R"
			)
			
			if restrictionsV[0] == nil &&  restrictionsR[0] == nil
				content << poolCSV + "," + u.name + "," + u.email + ",,\n"
			else
				restrictCSV = ""
				reasonCSV = ""
				if restrictionsV[0] != nil
					count = 0
					reasonCSV = restrictionsV[0].reason
					restrictionsV.each { |r|				
						rBegin = DateTime.parse(r.begin_time.iso8601).strftime("%d").to_i
						rEnd = DateTime.parse(r.end_time.iso8601).strftime("%d").to_i
						if count > 0
							restrictCSV << " "
						end
						count = count + 1
						if (rEnd - rBegin == 1)
							restrictCSV << rBegin.to_s
						elsif (rEnd - rBegin > 1)
							restrictCSV << rBegin.to_s + "-" + rEnd.to_s
						end
						content << poolCSV + "," + u.name + "," + u.email + "," + restrictCSV + "," + reasonCSV + "\n"
					}	
					
				end		
				restrictCSV = ""
				reasonCSV = ""
				if restrictionsR[0] != nil
					count = 0				
					reasonCSV = restrictionsR[0].reason
					restrictionsR.each { |r|				
						rBegin = DateTime.parse(r.begin_time.iso8601).strftime("%m").to_i
						rEnd = DateTime.parse(r.end_time.iso8601).strftime("%m").to_i
						if count > 0
							restrictCSV << " "
						end
						if (rEnd - rBegin == 1)
							restrictCSV << rBegin
						elsif (rEnd - rBegin > 1)
							restrictCSV << rBegin + "-" + rEnd
						end
						content << poolCSV + "," + u.name + "," + u.email + "," + restrictCSV + "," + reasonCSV + "\n"
					}	
					
				end
			end
		}	
	end
	
	def exportShifts(content, dept_id, beginDate, endDate)
		content << "Shifts\nJob,Pools,Begin,End,Repeat\n"
		shifts = Timetable.where("job_id IN (?) AND begin_time >= ? AND end_time <= ?",
			Job.where(department_id: dept_id), beginDate, endDate
		).order(:job_id)
		
		prevJobID = nil
		j = nil
		pools = nil
		shifts.each { |s| 
			if (s.job_id != prevJobID)
				prevJobID = s.job_id
				j = Job.find(s.job_id)
				pools = Pool.where(id: Jobpool.select(:pool_id).where(job_id: s.job_id))
			end
			
			count = 0
			poolsCSV = ""
			pools.each { |p| 
				if count > 0
					poolsCSV << " "
				end
				count = count + 1
				poolsCSV << p.name
			}
			
			content << j.name + "," + poolsCSV + ","
			content << s.begin_time.iso8601 + ","
			content << s.end_time.iso8601 + ",\n"  # no repeat yet	
		}
		# to-do optional: write fn to interpret shift patterns and shrink repeats
	end
	
	def exportInstructions(content)
		content << "Rules,,,,\nRule ID,Format,,,\n"
		content << "3,All individuals cannot work more than (24) hours in a (48) hour period,,,\n"
		content << ",,,,\n,,,,\nSpecial Fields,Staff list,,,\n"
		content << ",Other Search Conditions (Pools),Restrictions,Reason,\n"
		content << ",pool name, eg R5 R2,Single days, space separated (1 3 5),V - (Vacation),\n"
		content << ",dept. if OffService,Range, days of current month (15-20),P - Preferred Day Off,\n"
		content << ",,Weekend (wkd),O - Other,\n,,,,\n,Schedule,,,\n,Repeat,,,\n,W - Weekly,,,\n"
		content << ",D - Daily,,,\n,(DELAYED) R - Work Days,,,\n,(DELAYED) Mondays?,,,\n,,,,\n"
		content << ",Rules,,,\n,Format,,,\n,... detailed format to be designed,,,\n"
	end
	
	
	def getAlgInput
		filebreak = 'XXXPAGEENDXXX'
		inputString = CSV.generate do |csv|
			dept_id = (Employee.find_by_user_id((User.find_by_remember_token(cookies[:remember_token])).id)).department_id

			# get users
			employees = Employee.find_all_by_department_id(dept_id)
			employees.each { |e|
				user = User.find_by_id(e.user_id)
				csv << [user.id, user.name]
			}
			csv << [filebreak]
	
			# get restrictions
			employees.each { |e|
				restrictions = Restriction.where(:user_id => e.user_id).all
				restrictions.each { |r|
					csv << [r.user_id, r.begin_time.iso8601, r.end_time.iso8601, r.reason]
				}
			}
			csv << [filebreak]
			
			# get JobPoolUser
			jobPools = Jobpool.all
			jobPools.each { |p|
				poolUsers = Staff.find_all_by_pool_id(p.pool_id)
				poolUsers.each { |u|
					csv << [p.job_id, p.pool_id, u.user_id] 
				}
			}
			csv << [filebreak]
	
			# get timetable
			jobs = Job.where(:department_id => dept_id).all
			jobs.each { |j|
				jobPools = Jobpool.find_by_job_id(j.id)
				shifts = Timetable.where(:job_id => j.id).all
				shifts.each { |s|
					csv << [j.id, s.begin_time.iso8601, s.end_time.iso8601, j.in_hospital] 
				}
			}
			csv << [filebreak]
		end
		return inputString
	end  

	def timeCheck
		time1 = Time.new
		time2 = "Current Time : " + time1.inspect

		uri = URI.parse("http://localhost:8081/AlgorithmServer/AlgorithmServlet")
		session[:json] = getAlgInput() #for testing, comment out or delete for demo
		
		fpath = "C:\\Tony\\input_files\\alg_input.csv"
		file = File.open(fpath, "w")
		file.write(session[:json])
		file.close
		
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.body = getAlgInput()	# reads db
		session[:json] = request.body
		
		#session[:json] = "Algorithm is busy at work"
		response = http.request(request)
		session[:json] = response.body
		
		return session[:json]
		#return session[:temp]  # used to retrieve debugging messages out of parser
	end
	
	def initDB
		#User.create(name: email:)
			
	end
	
	def checkAlg
		
	end
	
end #end module
