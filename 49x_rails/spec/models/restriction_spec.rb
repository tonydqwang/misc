require 'spec_helper'

describe Restriction do
  before do
    @restriction = Restriction.new(reason: "Vacation", user_id: "1", begin_time: "2013-09-13 08:00:00", end_time: "2013-09-13 16:00:00")
  end
  
  subject { @restriction }
  
  it { should respond_to(:reason) }
  it { should respond_to(:user_id) }
  it { should respond_to(:begin_time) }
  it { should respond_to(:end_time) }
  
  it { should be_valid }
  
  describe "when reason is not present" do
    before { @restriction.reason = " " }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before { @restriction.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "when begin_time is not present" do
    before { @restriction.begin_time = " " }
    it { should_not be_valid }
  end
  
  describe "when end_time is not present" do
    before { @restriction.end_time = " " }
    it { should_not be_valid }
  end
end
