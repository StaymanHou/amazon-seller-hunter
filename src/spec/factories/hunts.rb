FactoryGirl.define do
  factory :hunt do
    isbn "978-0596514273"
    condition :new_book
    status :pending
    result "{}"
    created_at { Time.now }

    trait :invalid do
      isbn "nil"
    end

    trait :random_isbn do
      isbn { rand(2) == 0 ? "#{rand(10 ** 3).to_s.rjust(3, '0')}-#{rand(10 ** 10).to_s.rjust(10, '0')}" : "#{rand(10 ** 10).to_s.rjust(10, '0')}" }
    end

    trait :random_condition do
      condition { [ :new_book, :used_book ].sample }
    end

    trait :random_status do
      status { [ :pending, :working, :finished, :failed ].sample }
    end

    trait :random_result do
      result { "{\"seller_name\": \"#{(0...16).map { ('a'..'z').to_a[rand(26)] }.join}\", \"product_url\": \"http://www.amazon.com/gp/product/#{rand(10 ** 10)}/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=#{(0...13).map { ('a'..'z').to_a[rand(26)] }.join}\"}" }
    end

    factory :random_hunt, traits: [:random_isbn, :random_condition, :random_status, :random_result]
  end
end
