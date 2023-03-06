class Task < ApplicationRecord
  validates :task_name,  presence: true, length: { maximum: 50 }
  validates :task_detail,  presence: true, length: { maximum: 250 }
  
  scope :search_key_status, -> (keyword, status){ where("task_name LIKE ?", "%#{keyword}%").where(status: status) }
  scope :search_key,        -> (keyword){ where("task_name LIKE ?", "%#{keyword}%") }
  scope :search_status,     -> (status){ where(status: status) }
  
  belongs_to :user
  
  enum priority:{ High: 0, Middle: 1, Low: 2 }
end
