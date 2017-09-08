class Request < ApplicationRecord
  belongs_to :client, class_name: 'User', required: true
  belongs_to :agent, class_name: 'User', required: false

  validates :subject, presence: true

  has_many :messages, dependent: :destroy

  scope :open, -> { where(closed: nil) }
  scope :closed, -> { where.not(closed: nil).where(archived: nil) }
  scope :archived, -> { where.not(archived: nil) }

  after_initialize :set_opened

  private

  def set_opened
    self.opened ||= Time.zone.now
  end
end
