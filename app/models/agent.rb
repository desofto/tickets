class Agent < User
  has_many :requests, dependent: :nullify
  has_many :messages, foreign_key: :author_id
end
