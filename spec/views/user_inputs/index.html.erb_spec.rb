require 'rails_helper'

RSpec.describe "user_inputs/index", type: :view do
  before(:each) do
    assign(:user_inputs, [
      UserInput.create!(
        user: nil,
        data_usage: "9.99",
        call_time: 2,
        sms_usage: 3
      ),
      UserInput.create!(
        user: nil,
        data_usage: "9.99",
        call_time: 2,
        sms_usage: 3
      )
    ])
  end

  it "renders a list of user_inputs" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
