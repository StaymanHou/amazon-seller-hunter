When(/^I go to the home page$/) do
  visit root_path
end

When(/^I go to the rules list page$/) do
  visit rules_path
end

When(/^I go to the rule edit page of the (\d+)(?:st|nd|rd|th) rule$/) do |ordinal_number|
  index = ordinal_number.to_i - 1
  visit edit_rule_path(@rules[index])
end

Then(/^I should be on the rule edit page of the (\d+)(?:st|nd|rd|th) rule$/) do |ordinal_number|
  index = ordinal_number.to_i - 1
  current_path.should eq edit_rule_path(@rules[index])
end
