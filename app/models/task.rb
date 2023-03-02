class Task < ApplicationRecord
  validates :task_name,  presence: true, length: { maximum: 50 }
  validates :task_detail,  presence: true, length: { maximum: 250 }
end
