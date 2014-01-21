class Employee < ActiveRecord::Base
  attr_accessible :department_id, :user_id, :name
  belongs_to :department
  has_many :contracts, dependent: :destroy
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of(:department_id, :scope => :user_id)
  before_validation :default_department_id
  validate :check_valid_department
  
  def default_department_id
    temp_dept = Department.find_by_name(self.name)
	if temp_dept != nil
      temp_deptid = (Department.find_by_name(self.name)).id
	  self.department_id = temp_deptid
	end
  end
  
  def check_valid_department
    temp_dept = Department.find_by_name(self.name)
	if temp_dept == nil
		errors.add(:department_id, "The department name entered is invalid")
    end
  end
end


