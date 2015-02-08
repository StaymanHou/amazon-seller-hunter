Feature: Configure rules
  In order to configure rules
  As a user
  I want to see a list of rule configurations and configure it

  Background: Have two rule
    Given the rule
      """
      {
        "name": "default",
        "enabled": true,
        "settings": {
          "larger_than": "100"
        }
      }
      """
    And the rule
      """
      {
        "name": "useless",
        "enabled": false,
        "settings": {}
      }
      """

  Scenario: List rules
    When I go to the home page
    Then I should see "Configure rules"
    When I click "Configure rules"
    Then I should see "Name"
    And I should see "Enabled"
    And I should see "default"
    And I should see "useless"
    And I should see "true"
    And I should see "false"
    And I should see "larger_than"
    And I should see "100"

  Scenario: Update rules with valid value
    When I go to the rules list page
    Then I should see "Modify"
    When I click the 1st "Modify"
    Then I should be on the rule edit page of the 1st rule
    And I should see "Larger than"
    When I fill in "Larger than" with "90"
    And I uncheck "Enabled"
    And I click "Save"
    Then the "Larger than" field should contain "90"
    And the "Enabled" field should be unchecked
