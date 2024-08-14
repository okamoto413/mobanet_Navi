require 'rails_helper'

RSpec.describe "plans/new", type: :view do
  before(:each) do
    assign(:plan, Plan.new(
      name: "MyString",
      carrier: 1,
      monthly_fee: "9.99",
      data_capacity: "MyString",
      call_fee: "9.99",
      plan_type: 1
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input[name=?]", "plan[name]"

      assert_select "input[name=?]", "plan[carrier]"

      assert_select "input[name=?]", "plan[monthly_fee]"

      assert_select "input[name=?]", "plan[data_capacity]"

      assert_select "input[name=?]", "plan[call_fee]"

      assert_select "input[name=?]", "plan[plan_type]"
    end
  end
end
