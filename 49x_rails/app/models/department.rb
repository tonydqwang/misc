class Department < ActiveRecord::Base
  before_save { self.name = name.downcase }
  attr_accessible :name, :user_id
  has_many :rules, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :timetables, dependent: :destroy
  has_many :events, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
end
