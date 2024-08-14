FactoryBot.define do
  factory :user do
    email { "MyString" }
    encrypted_password { "MyString" }
    admin { false }
  end
end
