class Jobpool < ActiveRecord::Base
  attr_accessible :job_id, :pool_id
  belongs_to :pool
  belongs_to :job
  validates_uniqueness_of(:job_id, :scope => :pool_id)
end
