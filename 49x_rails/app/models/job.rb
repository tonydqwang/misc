class Job < ActiveRecord::Base
  attr_accessible :department_id, :in_hospital, :name
  validates_uniqueness_of(:name, :scope => [:department_id, :in_hospital])
  belongs_to :department
  
  has_many :jobpools, dependent: :destroy
  has_many :timetables, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :department_id, presence: true
  validates :in_hospital, presence: true
end
