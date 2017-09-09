class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: true

  def reset_authentication_token
    update_column(:auth_token, Devise.friendly_token)
  end

  def admin?
    type == 'Admin'
  end

  def client?
    type == 'Client'
  end

  def agent?
    type == 'Agent'
  end
end
