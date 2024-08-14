require 'rails_helper'

RSpec.describe "recommended_plans/show", type: :view do
  before(:each) do
    @recommended_plan = assign(:recommended_plan, RecommendedPlan.create!(
      user: nil,
      plan: nil,
      reason: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
