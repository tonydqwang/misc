require 'spec_helper'

describe Staff do
  before do
    @staff = Staff.new(job_id: "15", user_id: "1")
  end
  
  subject { @staff }
  
  it { should respond_to(:job_id) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @staff.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "when job_id is not present" do
    before { @staff.job_id = " " }
    it { should_not be_valid }
  end
end
