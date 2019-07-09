# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :category do
    title { FFaker::Internet.email }
  end
end
