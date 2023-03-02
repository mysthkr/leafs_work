FactoryBot.define do
  factory :task do
    task_name { 'test_name' }
    task_detail { 'test_detail' }
  end
  factory :second_task, class: Task do
    task_name { 'test_name_2' }
    task_detail { 'test_detail_2' }
  end
  factory :third_task, class: Task do
    task_name { 'test_name_3' }
    task_detail { 'test_detail_3' }
  end
  factory :forth_task, class: Task do
    task_name { 'test_name_4' }
    task_detail { 'test_detail_4' }
  end
  factory :fifth_task, class: Task do
    task_name { 'test_name_5' }
    task_detail { 'test_detail_5' }
  end
end