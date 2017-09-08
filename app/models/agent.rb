class Agent < User
  has_many :requests, dependent: :nullify
end
