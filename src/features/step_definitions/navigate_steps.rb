When(/^I go to the home page$/) do
  visit root_path
end

When(/^I go to the rules list page$/) do
  visit rules_path
end

When(/^I go to the rule edit page of the (\d+)(?:st|nd|rd|th) rule$/) do |ordinal_number|
  index = ordinal_number.to_i - 1
  visit hunt_path(@hunts[index])
end

When(/^I go to the show details page of the (\d+)(?:st|nd|rd|th) hunting$/) do |ordinal_number|
  index = ordinal_number.to_i - 1
  visit hunt_path(@hunts[index])
end

Then(/^I should be on the rule edit page of the (\d+)(?:st|nd|rd|th) rule$/) do |ordinal_number|
  index = ordinal_number.to_i - 1
  current_path.should eq edit_rule_path(@rules[index])
end

Then(/^I should be on the show details page of the (\d+)(?:st|nd|rd|th) hunting$/) do |ordinal_number|
  @hunts ||= Hunt.all
  index = ordinal_number.to_i - 1
  current_path.should eq hunt_path(@hunts[index])
end

Then(/^I should be on the (\d+)(?:st|nd|rd|th) page of the hunting list$/) do |page_number|
  current_url.should eq hunts_url(page: page_number)
end

Then(/^I should be on the new hunting page$/) do
  current_path.should eq new_hunt_path
end
