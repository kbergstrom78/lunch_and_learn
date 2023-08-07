require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :favorites }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'has_secure_password' do
    it 'should have a password digest' do
      user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user.password_digest).to be_present
    end
  end

  describe 'API key generation' do
    it 'generates an API key before create' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user.api_key).to be_nil

      user.save
      expect(user.api_key).to be_present
      expect(user.api_key.length).to eq(27)
    end

    it 'ensures the API key is unique' do
      existing_user = User.create(email: 'existing@example.com', password: 'password', password_confirmation: 'password')
      allow(SecureRandom).to receive(:alphanumeric).and_return(existing_user.api_key, 'new_unique_key')

      new_user = User.create(email: 'new@example.com', password: 'password', password_confirmation: 'password')
      expect(new_user.api_key).to eq('new_unique_key')
    end
  end
end
