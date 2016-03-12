# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { FFaker::Internet.email }
    body { FFaker::Lorem.words(10).join(' ') }
    comment { FFaker::Lorem.words(2).join(' ') }
  end
end
