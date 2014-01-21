module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
    end
  end

  def getScheduleRecords jsonString_Test
    a_hash = JSON.parse(jsonString_Test)
	
	

	  for inner_element in a_hash
	    new_record = Event.new
	    for key,value in inner_element
		  if key == "jobID"
            new_record.job_id = value
		  end
		  if key == "employeeID"
            new_record.user_id = value
		  end
		  if key == "timespan"
		    startTime = value.split("/").first
			endTime = value.split("/").last
			new_record.start_at = startTime
			new_record.end_at = endTime
          end
		end
	    new_record.save
	  end

  end
  
  def parseTime event_time
    event_array = event_time.split(" ")
	event_date = event_array[0]
	event_time = event_array[1]
	[event_date, event_time]
  end
  
  def timeCheck
    time1 = Time.new
    time2 = "Current Time : " + time1.inspect
	
	uri = URI.parse("http://localhost:8081/AlgorithmServer/AlgorithmServlet")
	
	file = "C:\\Downloads\\textfile.txt"
	fileTable = "C:\\Downloads\\sampleTimeTable.csv"
	fileUser = "C:\\Downloads\\sampleUser.csv"
	fileRest = "C:\\Downloads\\sampleUserRestrictions.csv"
	filePool = "C:\\Downloads\\sampleStaffPool.csv"
	
	post_body = []
	post_body << File.read(fileUser)
	post_body << File.read(fileRest)
	post_body << File.read(filePool)
	post_body << File.read(fileTable)

	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Post.new(uri.request_uri)
	request.body = post_body.join

	response = http.request(request)
	session[:json] = "Algorithm is busy at work"
	session[:json] = response.body
	return session[:json]
  end 
  def dropTable(department)
  
  end
  
end
