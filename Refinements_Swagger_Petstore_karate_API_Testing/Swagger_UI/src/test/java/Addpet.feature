Feature: Add Pet
  Scenario Outline: add a new pet to the store
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {"id": <userid>,"category": {"id": <petid>, "name": "Dog"},"name": <username>,"photoUrls": [<photourl>],"tags": [{"id": 0,"name": "dog1"}],"status": <status>}
    When method post
    Then status 200
    And match response.name contains 'James'
    Examples:
    | read('swaggerpet.csv') |


