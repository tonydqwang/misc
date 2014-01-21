class Restriction < ActiveRecord::Base
  attr_accessible :begin_time, :end_time, :reason, :user_id, :approve
  belongs_to :user
  validates :begin_time, presence: true
  validates :end_time, presence: true
  validates :reason, presence: true
  validates :user_id, presence: true
  validates :approve, :inclusion => {:in => [true, false]}
  validate :cannot_overlap, :begin_before_end
 
 private
	def cannot_overlap
		error_msg = "The restriction overlaps with another restriction: "
		Restriction.where(user_id: user.id).find_each do |restriction|
			if restriction.id != id
			
				if begin_time < restriction.begin_time 
					if end_time > restriction.begin_time
						error_msg = error_msg + restriction.begin_time.to_s + " to " + restriction.end_time.to_s
						errors.add(:overlap, error_msg)
						break
					end
				elsif begin_time < restriction.end_time
					error_msg = error_msg + restriction.begin_time.to_s + " to " + restriction.end_time.to_s
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

