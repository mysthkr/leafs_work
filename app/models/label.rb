class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
end
