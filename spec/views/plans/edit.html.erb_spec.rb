require 'rails_helper'

RSpec.describe "plans/edit", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      name: "MyString",
      carrier: 1,
      monthly_fee: "9.99",
      data_capacity: "MyString",
      call_fee: "9.99",
      plan_type: 1
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input[name=?]", "plan[name]"

      assert_select "input[name=?]", "plan[carrier]"

      assert_select "input[name=?]", "plan[monthly_fee]"

      assert_select "input[name=?]", "plan[data_capacity]"

      assert_select "input[name=?]", "plan[call_fee]"

      assert_select "input[name=?]", "plan[plan_type]"
    end
  end
end
