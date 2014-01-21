class Pool < ActiveRecord::Base
  attr_accessible :department_id, :name
  has_many :jobpools, dependent: :destroy
  has_many :staffs, dependent: :destroy
    
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  validates_uniqueness_of(:name, :scope => :department_id)
end
