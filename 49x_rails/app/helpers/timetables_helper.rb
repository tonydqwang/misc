module TimetablesHelper

  def getSchedule (jsonString_Test, department)
    a_hash = JSON.parse(jsonString_Test)
	
	
	for outer_element in a_hash
	  for inner_element in outer_element
	    new_record = Timetable.new
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
			new_record.begin_time = startTime
			new_record.end_time = endTime
          end
		end
		new_record.department_id = department.id
	    new_record.save
	  end
	
	end

  end
  
  def dropTable(department)
  
  end
  
  def twovars (user, department)
     var = 66
  end

  
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
end
