# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :article_category do
    title { FFaker::Internet.email }
    visible { [true, false].sample }
  end
end
