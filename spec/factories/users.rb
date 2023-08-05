FactoryBot.define do
  factory :user do
    name { 'Monty Python' }
    email { 'monty@holygrail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end