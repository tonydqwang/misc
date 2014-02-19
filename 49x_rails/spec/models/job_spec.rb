require 'spec_helper'

describe Job do
  before do
    @job = Job.new(name: "Software Developer", department_id: "1", in_hospital: true)
  end
  
  subject { @job }
  
  it { should respond_to(:name) }
  it { should respond_to(:department_id) }
  it { should respond_to(:in_hospital) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @job.name = " " }
    it { should_not be_valid }
  end
  
  describe "when department_id is not present" do
    before { @job.department_id = " " }
    it { should_not be_valid }
  end
  
  describe "when in_hospital is not present" do
    before { @job.in_hospital = " " }
    it { should_not be_valid }
  end
end
