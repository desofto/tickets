class Message < ApplicationRecord
  belongs_to :request, required: true

  validates :body, presence: true

  after_save :broadcast

  private

  def broadcast
    MessageBroadcastJob.perform_later(self)
  end
end
