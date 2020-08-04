class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    before_create :generate_auth_code

    has_many :carts

  def generate_auth_code
    self.auth_token = SecureRandom.hex(4)
  end
end
