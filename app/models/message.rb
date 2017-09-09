class Message < ApplicationRecord
  belongs_to :request, required: true
  belongs_to :author, class_name: 'User', required: true

  validates :body, presence: true

  after_save :broadcast

  private

  def broadcast
    MessageBroadcastJob.perform_later(self)
  end
end
