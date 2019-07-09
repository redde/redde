# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :manager do
    email { FFaker::Internet.email }
    password { '123123aA' }
    password_confirmation { '123123aA' }
  end
end
