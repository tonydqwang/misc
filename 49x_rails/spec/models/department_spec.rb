require 'spec_helper'

describe Department do
  before do
    @department = Department.new(name: "Queen's University")
  end
  
  subject { @department }
  
  it { should respond_to(:name) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @department.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @department.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when department name is already taken" do
    before do
      department_with_same_name = @department.dup
      department_with_same_name.name = @department.name.upcase
      department_with_same_name.save
    end

    it { should_not be_valid }
  end
  
end
