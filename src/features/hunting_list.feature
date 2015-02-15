Feature: Home page show a list of latest huntings
  In order to view all the huntings
  As a user
  I want to see a list of huntings in home page

  Background: Have 30 huntings with random created time, random status and result
    Given 30 huntings with random created time, "random" isbn, "random" condition, "random" status and "random" result

  Scenario: List latest 25 huntings in home page
    When I go to the home page
    Then I should see the latest 25 huntings 

  Scenario: List huntings 26 to 30 ordered by created time in second page
    When I go to the home page
    Then I should see 2 in page nav bar
    When I click 2 in page nav bar
    Then I should be on the 2nd page of the hunting list
    And I should see the 26 to 30 huntings ordered by created time
