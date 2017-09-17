class Task < ApplicationRecord
  validates :status, presence: true, length: { minimum: 1 }
end
