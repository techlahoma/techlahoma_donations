Feature: Membership
  As a cool Oklhaoma techie
  I want to join Techlahoma

  #@javascript @stripe
  Scenario: Getting to a membership form
    Given a new user
    When they visit the home page
    Then they should see "Join"
