# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  before_validation :generate_api_key, on: :create

  private

  def generate_api_key
    return if api_key.present?

    loop do
      self.api_key = SecureRandom.alphanumeric(12)
      break unless User.exists?(api_key:)
    end
  end
end
