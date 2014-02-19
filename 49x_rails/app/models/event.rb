class Event < ActiveRecord::Base
  attr_accessible :start_at, :end_at, :name, :color, :department_id, :job_id, :user_id, :user_email
  validate :check_Duplicate, :check_valid_user, :check_valid_department
  before_save :default_color
  before_validation :default_department_id, :default_user_attributes
  
  belongs_to :department
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :job_id, presence: true, numericality: { only_integer: true }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :name, presence: true
  validates :color, presence: true
  validates :user_email, presence: true
  has_event_calendar
  
  def check_Duplicate
    temp_event_array = Event.where(user_email: self.user_email)
	dept_name = (Department.find_by_id(Job.find_by_id(self.job_id).department_id)).name
	temp_dept_id = Department.find_by_name(dept_name).id
	for record in temp_event_array do
	  if ((record.start_at == self.start_at) && (record.end_at == self.end_at) && (record.department_id == self.department_id))
	    errors.add(:user_email, "invalid combination of user_email, start_at, end_at, department, duplicate in table")
	  end
	end
  end
  
  def check_valid_department
	if self.department_id == nil
    	dept_name = (Department.find_by_id(Job.find_by_id(self.job_id).department_id)).name
		errors.add(:department_id, "The user does not belong the department #{dept_name}")
    end
  end
  
  def check_valid_user
    temp_user = User.find_by_id(user_id)
	if temp_user == nil
	  errors.add(:user_id, "invalid user id")
	end
	
    #temp_user_2 = User.find_by_email(user_email)
	#if temp_user_2 == nil
	  #errors.add(:user_email, "invalid user email")
	#end
	
	#if temp_user != temp_user_2
	  #errors.add(:user_id, "invalid user_email and user_id combination")
	#end
  end
  
  
  def default_color
  
    color_array = ["#FFFF00", "#FF3300", "#00FF00", "#00CCFF", "#CC66FF", "#FF6600"]
    randomVar = rand(0..5)
	current_email = self.user_email
	existing_color = (Event.find_by_user_email(current_email))
	
	if existing_color == nil
	  self.color = color_array[randomVar]
	elsif existing_color.color == "#9aa4ad"
	   self.color = color_array[randomVar]
	else
	  self.color = existing_color.color
	end
  end
  
  def default_department_id
    
  	dept_name = (Department.find_by_id(Job.find_by_id(self.job_id).department_id)).name
	temp_dept_id = Department.find_by_name(dept_name).id
	temp_employee_array = Employee.where(user_id: self.user_id)
	
	temp_employee = Employee.find_by_user_id(self.user_id)
	for record in temp_employee_array do
	  if (record.department_id == temp_dept_id)
	    self.department_id = temp_dept_id
	  end
	end
  end
  
  def default_user_attributes
  
    temp_user = User.find_by_id(user_id)
    if temp_user != nil
	  self.name = (User.find_by_id(self.user_id)).name
	  self.user_email = (User.find_by_id(self.user_id)).email
	end
  end
  
end

