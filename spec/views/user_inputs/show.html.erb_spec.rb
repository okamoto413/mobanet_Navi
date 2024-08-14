require 'rails_helper'

RSpec.describe "user_inputs/show", type: :view do
  before(:each) do
    @user_input = assign(:user_input, UserInput.create!(
      user: nil,
      data_usage: "9.99",
      call_time: 2,
      sms_usage: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
