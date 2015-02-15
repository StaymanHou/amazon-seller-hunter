def create_hunt(created_time, isbn, condition, status, result)
  traits = []
  named_args = {}
  if created_time == 'random'
    named_args[:created_at] = rand(1.hour).seconds.ago
  end
  if isbn == 'random'
    traits << :random_isbn
  else
    named_args[:isbn] = isbn
  end
  if condition == 'random'
    traits << :random_condition
  else
    named_args[:condition] = condition.to_sym
  end
  if status == 'random'
    traits << :random_status
  else
    named_args[:status] = status.to_sym
  end
  if result == 'random'
    traits << :random_result
  else
    named_args[:result] = result
  end
  FactoryGirl.create(:hunt, *traits, named_args)
end

Given(/^(a|\d+) hunting(?:s)? with (current|random) created time, "(.*?)" isbn, "(.*?)" condition, "(.*?)" status and "(.*?)" result$/) do |lex_number_of_hunts, created_time, isbn, condition, status, result|
  number_of_hunts = lex_number_of_hunts == 'a' ? 1 : lex_number_of_hunts.to_i
  @hunts ||= []
  number_of_hunts.times do
    @hunts << create_hunt(created_time, isbn, condition, status, result)
  end
end

Given(/^a hunting with current created time, "(.*?)" isbn, "(.*?)" condition, "(.*?)" status and the result$/) do |isbn, condition, status, result|
  @hunts ||= []
  @hunts << create_hunt('current', isbn, condition, status, result)
end

Then(/^I should see the latest (\d+) huntings$/) do |number_of_hunts|
  sorted_hunts = @hunts.sort_by { |hunt| hunt.created_at }.reverse
  for i in 1..number_of_hunts.to_i do
    page.should have_content sorted_hunts[i-1].isbn
  end
end

Then(/^I should see the (\d+) to (\d+) huntings ordered by created time$/) do |number_of_hunts_from, number_of_hunts_to|
  sorted_hunts = @hunts.sort_by { |hunt| hunt.created_at }.reverse
  for i in number_of_hunts_from.to_i..number_of_hunts_to.to_i do
    page.should have_content sorted_hunts[i-1].isbn
  end
end

