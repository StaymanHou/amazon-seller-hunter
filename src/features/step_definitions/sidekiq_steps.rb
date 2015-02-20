Then(/^hunter should go async$/) do
  expect(Hunter.jobs.size).to be >= 1
end
