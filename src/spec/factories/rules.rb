FactoryGirl.define do
  factory :rule do
    name "default"
    enabled true
    settings { {'larger_than' => 100} }
  end
end
