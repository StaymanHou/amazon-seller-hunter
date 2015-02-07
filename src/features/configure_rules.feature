Feature: Configure rules
  In order to configure rules
  As a user
  I want to see a list of rule configurations and configure it

  Background: Have two rule
    Given the 1st rule
      """
      {
        "name": "default",
        "enabled": "true",
        "settings": {
          "larger_than": "100"
        }
      }
      """
    And the 2nd rule
      """
      {
        "name": "useless",
        "enabled": "true",
        "settings": {}
      }
      """

  Scenario: List rules
    When I go to the home page
    Then I should see "Configurations"
    When I click "Configurations"
    Then I should see "name"
    And I should see "enabled"
    And I should see "default"
    And I should see "useless"
    And I should see "true"
    And I should see "false"
    And I should see "larger_than"
    And I should see "100"

  Scenario: Update rules with valid value
    When I go to the rules list page
    Then I should see "Modify"
    When I click the 2nd "Modify"
    Then I should be on the rule edit page of the 2nd rule
    And I should see "larger_than"
    When I fill in "larger_than" with "90"
    And I select "false" from "enabled"
    And I click "Save"
    Then I should see "90"
    And I should see "false"

  Scenario: Update rules, name must be precent and unique
    When I go to the rule edit page of the 2nd rule
    Then the "name" field should be disabled

  Scenario: Update rules, enabled must be precent
    When I go to the rule edit page of the 2nd rule
    Then the "enabled" filed should be "enabled,disabled"
