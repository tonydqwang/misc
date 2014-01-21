require 'spec_helper'

describe Rule do
  before do
    @rule = Rule.new(name: "Maximum of 60hr/wk", department_id: "1")
  end
  
  subject { @rule }
  
  it { should respond_to(:name) }
  it { should respond_to(:department_id) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @rule.name = " " }
    it { should_not be_valid }
  end
  
  describe "when department_id is not present" do
    before { @rule.department_id = " " }
    it { should_not be_valid }
  end
end
