When(/^I click "(.*?)"$/) do |anchor_text|
  click_on anchor_text
end

When(/^I click the (\d+)(?:st|nd|rd|th) "(.*?)"$/) do |ordinal_number, anchor_text|
  index = ordinal_number.to_i - 1
  page.all('a', text: anchor_text)[index].click
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content content
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, text|
  fill_in field, with: text
end

When(/^I select "(.*?)" from "(.*?)"$/) do |option, field|
  select option, from: field
end

When(/^I (un)?check "(.*?)"$/) do |uncheck_flag, field|
  if uncheck_flag
    uncheck field
  else
    check field
  end
end

Then(/^the "(.*?)" field should have options "(.*?)"$/) do |field, options|
  pending # express the regexp above with the code you wish you had
end

Then(/^the "([^\"]*)" field should contain "([^\"]*)"$/) do |field, value|
  field_labeled(field).value.should =~ /#{value}/
end

Then(/^the "(.*?)" field should be (un)?checked$/) do|field, uncheck_flag|
  if uncheck_flag
    field_labeled(field).should_not be_checked
  else
    field_labeled(field).should be_checked
  end
end
