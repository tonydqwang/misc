require 'spec_helper'

describe Employee do
  before do
    @employee = Employee.new(department_id: "1", user_id: "1")
  end
  
  subject { @employee }
  
  it { should respond_to(:department_id) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe "when department_id is not present" do
    before { @employee.department_id = " " }
    it { should_not be_valid }
  end
  
  describe "user_id is not present" do
    before { @employee.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "when user_id already belongs to a department" do
    before do
      employee_with_same_attributes = @employee.dup
      employee_with_same_attributes.user_id = @employee.user_id
	  employee_with_same_attributes.department_id = @employee.department_id
      employee_with_same_attributes.save
    end

    it { should_not be_valid }
  end
  
  describe "when user_id already exists in table but department will be different" do
    before do
      employee_with_same_attributes = @employee.dup
      employee_with_same_attributes.user_id = @employee.user_id
	  employee_with_same_attributes.department_id = "2"
      employee_with_same_attributes.save
    end

    it { should be_valid }
  end
  
  describe "when department_id already exists in table but user_id will be different" do
    before do
      employee_with_same_attributes = @employee.dup
      employee_with_same_attributes.user_id = "2"
	  employee_with_same_attributes.department_id = @employee.department_id
      employee_with_same_attributes.save
    end

    it { should be_valid }
  end
end
