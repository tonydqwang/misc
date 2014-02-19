class CalendarController < ApplicationController
  
  def index

 

	#@event_strips = Event.testRuoran(@shown_month)
	
	# To restrict what events are included in the result you can pass additional find options like this:
    #
    # @event_strips = Event.event_strips_for_month(@shown_month, :include => :some_relation, :conditions => 'some_relations.some_column = true')
    #
	
  end
  
  def show
	
	@eventid = params[:id]
	if @eventid == nil
	  current_user
	  current_employee @current_user
	  
	  @current_event = Event.find_by_user_id(@current_user.id)
	  if (@current_event == nil)
	    @schedule_msg =  "The system currently does not have a schedule for you"
	  else
	    @month = (params[:month] || (Time.zone || Time).now.month).to_i
        @year = (params[:year] || (Time.zone || Time).now.year).to_i
        @shown_month = Date.civil(@year, @month)
		@single_event = @current_event
		@event_strips = Event.event_strips_for_month(@shown_month, 0, :conditions => ["(user_id == #{@single_event.user_id})"])
		@flag = true
	  end
	  
	  
	else
	
	  @month = (params[:month] || (Time.zone || Time).now.month).to_i
      @year = (params[:year] || (Time.zone || Time).now.year).to_i
      @shown_month = Date.civil(@year, @month)
      @single_event = Event.find(params[:id])
	
	  @event_strips = Event.event_strips_for_month(@shown_month, 0, :conditions => ["(user_id == #{@single_event.user_id})"])
	  @flag = true
	  @current_event = @single_event
	end
  end
  
end
