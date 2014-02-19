require 'spec_helper'

describe "contracts/edit" do
  before(:each) do
    @contract = assign(:contract, stub_model(Contract,
      :employee_id => 1
    ))
  end

  it "renders the edit contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contracts_path(@contract), :method => "post" do
      assert_select "input#contract_employee_id", :name => "contract[employee_id]"
    end
  end
end
