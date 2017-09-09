class Request < ApplicationRecord
  belongs_to :client, class_name: 'User', required: true
  belongs_to :agent, class_name: 'User', required: false

  validates :subject, presence: true

  has_many :messages, dependent: :destroy

  enum status: %i(open answered closed archived)

  after_initialize :set_opened

  after_save :broadcast

  before_save :update_timestamps

  default_scope { reorder(:status).order(updated_at: :desc) }

  private

  def update_timestamps
    self.opened   ||= Time.zone.now if open?
    self.answered ||= Time.zone.now if answered?
    self.closed   ||= Time.zone.now if closed?
    self.archived ||= Time.zone.now if archived?
  end

  def broadcast
    RequestBroadcastJob.perform_later(self, is_new: id_before_last_save.blank?)
  end

  def set_opened
    self.status ||= 'open'
    self.opened ||= Time.zone.now
  end
end
