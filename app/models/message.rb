class Message < ApplicationRecord
  belongs_to :request, required: true

  validates :body, presence: true
end
