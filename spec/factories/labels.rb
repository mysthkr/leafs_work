FactoryBot.define do
  factory :label do
    name { "Label1" }
  end
  factory :second_label, class: Label do
    name { "Label2" }
  end
  factory :third_label , class: Label do
    name { "Label3" }
  end
  factory :forth_label , class: Label do
    name { "Label4" }
  end
  factory :fifth_label , class: Label do
    name { "Label5" }
  end
end
