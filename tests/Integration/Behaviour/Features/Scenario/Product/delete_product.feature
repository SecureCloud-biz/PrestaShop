# ./vendor/bin/behat -c tests/Integration/Behaviour/behat.yml -s product --tags delete
@reset-database-before-feature
@clear-cache-after-feature
@delete
Feature: Delete products from Back Office (BO)
  As an employee
  I need to be able to delete product and multiple products at once from BO

  Scenario: I delete product
    Given I add product "product1" with following information:
      | name       | en-US:bottle of ale  |
      | is_virtual | false                |
    And product "product1" type should be standard
    When I delete product product1
    Then product product1 should not exist anymore

  Scenario: I bulk delete products
    Given I add product "product1" with following information:
      | name       | en-US:bottle of wine |
      | is_virtual | false                |
    Given I add product "product2" with following information:
      | name       | en-US:jar of mead    |
      | is_virtual | false                |
    Given I add product "product3" with following information:
      | name       | en-US:gilded axe     |
      | is_virtual | false                |
    And product "product1" type should be standard
    And product "product2" type should be standard
    And product "product3" type should be standard
    When I bulk delete following products:
      | reference |
      | product1  |
      | product2  |
    Then product product1 should not exist anymore
    And product product2 should not exist anymore
    And product "product3" type should be standard
