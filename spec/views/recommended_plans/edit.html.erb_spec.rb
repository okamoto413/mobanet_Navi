require 'rails_helper'

RSpec.describe "recommended_plans/edit", type: :view do
  before(:each) do
    @recommended_plan = assign(:recommended_plan, RecommendedPlan.create!(
      user: nil,
      plan: nil,
      reason: "MyText"
    ))
  end

  it "renders the edit recommended_plan form" do
    render

    assert_select "form[action=?][method=?]", recommended_plan_path(@recommended_plan), "post" do

      assert_select "input[name=?]", "recommended_plan[user_id]"

      assert_select "input[name=?]", "recommended_plan[plan_id]"

      assert_select "textarea[name=?]", "recommended_plan[reason]"
    end
  end
end
