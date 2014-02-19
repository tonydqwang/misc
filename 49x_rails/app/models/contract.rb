class Contract < ActiveRecord::Base
	attr_accessible :begin_time, :employee_id, :end_time
	belongs_to :employee
	validates :begin_time, presence: true
	validates :end_time, presence: true
	validates :employee_id, presence: true
	validate :cannot_overlap, :begin_before_end
	
	private
	def cannot_overlap
		error_msg = "The contract overlaps with another contract: "
		Contract.where(employee_id: employee.id).find_each do |c|
			if c.id != id
				if begin_time <= c.begin_time
					if c.begin_time <= end_time
						error_msg = error_msg + c.begin_time.to_s + " to " + c.end_time.to_s
						errors.add(:overlap, error_msg)
						break
					end
				elsif begin_time <= c.end_time
					error_msg = error_msg + c.begin_time.to_s + " to " + c.end_time.to_s
					errors.add(:overlap,  error_msg)
					break
				end
			end		
		end
	end
		
	def begin_before_end
		if begin_time > end_time
			errors.add(:overlap, "The begin time is after the end time.")
		end
	end
end
