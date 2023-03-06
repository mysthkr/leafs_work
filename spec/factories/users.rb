FactoryBot.define do
  factory :user do
    name { "test10" }
    email { "test10@gmail.com" }
    password { "password" }
    password_confirmation { password }
    admin {true}
  end
  factory :second_user, class: Task do
    name { 'test20' }
    email { 'test20@gmail.com' }
    password { "password" }
    password_confirmation { password }
    admin {false}
  end
end
