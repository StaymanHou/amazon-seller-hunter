FactoryGirl.define do
  factory :rule do
    name 'default'
    enabled true
    settings { {'larger_than' => '100'} }

    trait :invalid do
      enabled nil
    end

    trait :valid do
      settings { {'larger_than' => '90'} }
    end

    factory :invalid_rule, traits: [:invalid]
    factory :valid_rule, traits: [:valid]
  end
end
