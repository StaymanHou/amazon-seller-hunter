Feature: Start hunting
  In order to hunt best seller
  As a user
  I want to start a hunt

  Scenario: Start a new hunting
    When I go to the home page
    Then I should see "Start a new hunting"
    When I click "Start a new hunting"
    Then I should be on the new hunting page
    When I fill in "ISBN" with "1234567890"
    And I select "New book" from "Condition"
    And I click "Start"
    Then I should be on the show details page of the 1st hunting
    And I should see "1234567890"
    And I should see "New book"
    And background job should start
