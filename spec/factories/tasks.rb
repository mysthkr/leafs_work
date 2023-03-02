FactoryBot.define do
  factory :task do
    task_name { 'test_name' }
    task_detail { 'test_detail' }
  end
   factory :second_task, class: Task do
    task_name { 'test_name_2' }
    task_detail { 'test_detail_2' }
  end
end