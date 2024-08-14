FactoryBot.define do
  factory :plan do
    name { "MyString" }
    carrier { 1 }
    monthly_fee { "9.99" }
    data_capacity { "MyString" }
    call_fee { "9.99" }
    plan_type { 1 }
  end
end
