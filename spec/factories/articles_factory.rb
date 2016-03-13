# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { FFaker::Internet.email }
    body { FFaker::Lorem.words(10).join(' ') }
    published_at { 1.day.ago }
    comment { FFaker::Lorem.words(2).join(' ') }
  end
end
