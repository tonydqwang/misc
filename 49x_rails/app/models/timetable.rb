class Timetable < ActiveRecord::Base
  attr_accessible :job_id, :begin_time, :end_time, :info
  belongs_to :job
  validates :job_id, presence: true, numericality: { only_integer: true }
  validates :begin_time, presence: true
  validates :end_time, presence: true
end
