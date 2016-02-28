Given(/^a new user$/) do
end

When(/^they visit the home page$/) do
  visit '/'
end

Then(/^they should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
