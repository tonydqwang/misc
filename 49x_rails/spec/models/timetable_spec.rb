require 'spec_helper'

describe Timetable do
  before do
    @timetable = Timetable.new(department_id: "1", user_id: "1", job_id: "1", start_at: "2013-08-23T06:00:00.000-05:00", end_at: "2013-08-23T18:00:00.000-05:00")
  end
  
  subject { @timetable }
  
  it { should respond_to(:department_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:job_id) }
  it { should respond_to(:start_at) }
  it { should respond_to(:end_at) }
  
  it { should be_valid }
  
  describe "when department_id is not present" do
    before { @timetable.department_id = " " }
    it { should_not be_valid }
  end
  
  describe "user_id is not present" do
    before { @timetable.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "job_id is not present" do
    before { @timetable.job_id = " " }
    it { should_not be_valid }
  end
  
  describe "start_at is not present" do
    before { @timetable.start_at = " " }
    it { should_not be_valid }
  end
  
  describe "end_at is not present" do
    before { @timetable.end_at = " " }
    it { should_not be_valid }
  end

end
