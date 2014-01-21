require 'spec_helper'

describe Allfile do
  before do
    @allfile = Allfile.new(name: "March Schedule", user_id: "1")
  end
  
  subject { @allfile }
  
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:schedulefile) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @allfile.name = " " }
    it { should_not be_valid }
  end
  
  describe "when user id already in table" do
    before do
      allfile_with_same_user_id = @allfile.dup
      allfile_with_same_user_id.user_id = @allfile.user_id
      allfile_with_same_user_id.save
    end

    it { should_not be_valid }
  end
end
