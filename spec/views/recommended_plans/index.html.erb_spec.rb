require 'rails_helper'

RSpec.describe "recommended_plans/index", type: :view do
  before(:each) do
    assign(:recommended_plans, [
      RecommendedPlan.create!(
        user: nil,
        plan: nil,
        reason: "MyText"
      ),
      RecommendedPlan.create!(
        user: nil,
        plan: nil,
        reason: "MyText"
      )
    ])
  end

  it "renders a list of recommended_plans" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
