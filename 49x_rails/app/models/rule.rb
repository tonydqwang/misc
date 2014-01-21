class Rule < ActiveRecord::Base
  attr_accessible :department_id, :name
  belongs_to :department
  validates :name, presence: true
  validates :department_id, presence: true
end
