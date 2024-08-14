require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      name: "Name",
      carrier: 2,
      monthly_fee: "9.99",
      data_capacity: "Data Capacity",
      call_fee: "9.99",
      plan_type: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Data Capacity/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
  end
end
