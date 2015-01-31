Feature: Show the details of a hunting
  In order to get the result or status of a hunting
  As a user
  I want to see the details of a huntings

  Background: Have 4 huntings with random created time, pending/working/finished/failed status and random result
    Given a hunting with current created time, random isbn, random condition, pending status and random result
    Given a hunting with current created time, random isbn, random condition, working status and random result
    Given a hunting with current created time, random isbn, random condition, finished status and the result
      """
      {
        "seller_name": "pbshop",
        "product_url": "http://www.amazon.com/gp/product/1449335837/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=AGLPMRINU0Q3T"
      }
      """
    Given a hunting with current created time, random isbn, random condition, failed status and the result
      """
      {
        "error_message": "Can not find any seller meets our criteria"
      }
      """

  Scenario: Show details link
    When I go to the home page
    Then I should see "show details" 4 times
    When I click the 1st "show details"
    Then I should be on the show details page of the 1st hunting

  Scenario: Details of the pending hunting
    When I go to the show details page of the 1st hunting
    Then I should see "Pending"

  Scenario: Details of the working hunting
    When I go to the show details page of the 1st hunting
    Then I should see "Working"

  Scenario: Details of the finished hunting
    When I go to the show details page of the 1st hunting
    Then I should see "Finished"
    And I should see "Seller Name"
    And I should see "pbshop"
    And I should see "Product Url"
    And I should see "http://www.amazon.com/gp/product/1449335837/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=AGLPMRINU0Q3T"

  Scenario: Details of the failed hunting
    When I go to the show details page of the 1st hunting
    Then I should see "Failed"
    And I should see "Error Message"
    And I should see "Can not find any seller meets our criteria"
