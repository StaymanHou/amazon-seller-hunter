def create_with_json_string(model, json_string)
  json_hash = JSON.parse(json_string)
  FactoryGirl.create(model, json_hash)
end

Given(/^the rule$/) do |json_string|
  @rules ||= []
  @rules << create_with_json_string(:rule, json_string)
end
