class Allfile < ActiveRecord::Base
  attr_accessible :schedulefile, :user_id, :name, :master_loadform
  validates :name, presence: true
  validates :user_id, presence: true, uniqueness: { case_sensitive: false }, numericality: { only_integer: true }
  mount_uploader :schedulefile, SchedulefileUploader
  mount_uploader :master_loadform, SchedulefileUploader
end
