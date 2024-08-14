require 'rails_helper'

RSpec.describe "recommended_plans/new", type: :view do
  before(:each) do
    assign(:recommended_plan, RecommendedPlan.new(
      user: nil,
      plan: nil,
      reason: "MyText"
    ))
  end

  it "renders new recommended_plan form" do
    render

    assert_select "form[action=?][method=?]", recommended_plans_path, "post" do

      assert_select "input[name=?]", "recommended_plan[user_id]"

      assert_select "input[name=?]", "recommended_plan[plan_id]"

      assert_select "textarea[name=?]", "recommended_plan[reason]"
    end
  end
end
