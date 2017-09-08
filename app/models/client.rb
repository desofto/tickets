class Client < User
  has_many :requests, dependent: :nullify
end
