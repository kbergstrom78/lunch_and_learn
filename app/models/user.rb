class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  before_create :generate_api_key

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.alphanumeric(12)
      break unless User.exists?(api_key: api_key)
    end
  end
end




