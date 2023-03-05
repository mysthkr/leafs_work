FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@gmail.com" }
    digest_password { "password" }
    admin {true}
  end
  factory :second_user, class: Task do
    name { 'test2' }
    email { 'test2@gmail.com' }
    digest_password { "password" }
    admin {false}
  end
end
