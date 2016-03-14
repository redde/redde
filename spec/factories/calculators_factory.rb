FactoryGirl.define do
  factory :calculator do
    name { FFaker::Internet.email }
  end
end
