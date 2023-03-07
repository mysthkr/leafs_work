FactoryBot.define do
  factory :task do
    task_name { 'test_name' }
    task_detail { 'test_detail' }
    due_date {"2023-03-02 15:21:26"}
    status {"ToDo"}
    priority {2}
    user_id {1}
  end
  factory :second_task, class: Task do
    association :label
    task_name { 'test_name_2' }
    task_detail { 'test_detail_2' }
    due_date {"2023-03-01 14:21:26"}
    status {"Doing"}
    priority {2}
    user_id {1}
    label_ids {[1]}
  end
  factory :third_task, class: Task do
    task_name { 'test_name_3' }
    task_detail { 'test_detail_3' }
    due_date {"2023-03-01 10:21:26"}
    status {"ToDo"}
    priority {1}
    user_id {1}
  end
  factory :forth_task, class: Task do
    task_name { 'test_name_4' }
    task_detail { 'test_detail_4' }
    due_date {"2023-03-02 10:21:26"}
    status {"Done"}
    priority {0}
    user_id {1}
  end
  factory :fifth_task, class: Task do
    task_name { 'test_name_5' }
    task_detail { 'test_detail_5' }
    due_date {"2023-03-03 15:21:26"}
    status {"ToDo"}
    priority {2}
    user_id {1}
  end
end