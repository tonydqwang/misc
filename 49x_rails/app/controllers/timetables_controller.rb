class TimetablesController < ApplicationController

  require "rubygems"
  require "json"


	def new
	@timetable = Timetable.new
	end
  
	def create
		@timetable = Timetable.new(params[:timetable])
		if @timetable.save
		  flash[:success] = "New shift created!"
		  redirect_to @timetable
		else
		  render 'new'
		end
	end
	
	def edit
		@timetable = session[:timetable]
	end
	
	def update
  
		@timetable = Timetable.find_by_id(params[:id])
		
		if params["Update Timetable"]
			@timetable = Timetable.find_by_id(params[:timetable][:my_variable])
			session[:timetable] = @timetable
			redirect_to edit_timetable_path
		
		elsif @timetable.update_attributes(params[:timetable])
			flash[:success] = "timetable updated!"

			redirect_to @timetable
		else
			render 'edit'
		end
	end
  
	def show
		@current_jobs = Department.find_by_name(session[:dept_name].downcase).jobs
		@job_ids = @current_jobs.collect{|j| j.id}
		@timetables = Timetable.where("job_id IN (?)", @job_ids)
	end
  
	def search
	end
  
	def find
	end
  
	def index
		@month = (params[:month] || (Time.zone || Time).now.month).to_i
		@year = (params[:year] || (Time.zone || Time).now.year).to_i

		@shown_month = Date.civil(@year, @month)

		@event_strips = Event.event_strips_for_month(@shown_month)
	end
end
