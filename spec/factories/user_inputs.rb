FactoryBot.define do
  factory :user_input do
    user { nil }
    data_usage { "9.99" }
    call_time { 1 }
    sms_usage { 1 }
  end
end
