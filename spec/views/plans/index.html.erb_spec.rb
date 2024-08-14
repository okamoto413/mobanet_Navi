require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        name: "Name",
        carrier: 2,
        monthly_fee: "9.99",
        data_capacity: "Data Capacity",
        call_fee: "9.99",
        plan_type: 3
      ),
      Plan.create!(
        name: "Name",
        carrier: 2,
        monthly_fee: "9.99",
        data_capacity: "Data Capacity",
        call_fee: "9.99",
        plan_type: 3
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Data Capacity".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
