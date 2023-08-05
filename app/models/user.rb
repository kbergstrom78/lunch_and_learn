class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  before_create :generate_api_key

  private

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.alphanumeric(12)
      break unless User.exists?(api_key: api_key)
    end
  end
end




