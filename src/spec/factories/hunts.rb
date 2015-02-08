FactoryGirl.define do
  factory :hunt do
    isbn "978-0596514273"
    condition 0
    status 0
    result "{}"
  end

  trait :random_isbn do
    enabled { "#{rand(10 ** 4)}-#{rand(10 ** 10)}" }
  end

  factory :random_hunt, traits: [:random_isbn]
end
