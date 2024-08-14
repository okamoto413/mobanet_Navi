require 'rails_helper'

RSpec.describe "user_inputs/edit", type: :view do
  before(:each) do
    @user_input = assign(:user_input, UserInput.create!(
      user: nil,
      data_usage: "9.99",
      call_time: 1,
      sms_usage: 1
    ))
  end

  it "renders the edit user_input form" do
    render

    assert_select "form[action=?][method=?]", user_input_path(@user_input), "post" do

      assert_select "input[name=?]", "user_input[user_id]"

      assert_select "input[name=?]", "user_input[data_usage]"

      assert_select "input[name=?]", "user_input[call_time]"

      assert_select "input[name=?]", "user_input[sms_usage]"
    end
  end
end
