Feature: Karate run
  Scenario: upload file
    * def response1 = call read('classpath:Addpet.feature')
    Given url 'https://petstore.swagger.io/v2/pet/'
    Given path response1.response.category.id
    Given path '/uploadImage'
# refer to the second scenario in this file for how to set the upload filename using the 'multipart file' syntax
    And multipart field file = read('maxresdefault.jpg')
    And header accept = 'application/json'
    And header Content-Type = 'multipart/form-data'
    When method post
    Then status 200
    And match response.message contains 'File uploaded'

  Scenario Outline: Update an existing pet
    Given url 'https://petstore.swagger.io/v2/pet'
    * def id = petid.toString()
    And request {"id": 1,"category": {"id": #(~~id),"name": "Dog"},"name": <updated_username>,"photoUrls": ["https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497&w=740&h=416"],"tags": [{"id": 0,"name": "dog1"}],"status": <status>}
    When method put
    Then status 200
    And match response.name contains 'James Anderson'
   Examples:
    |updated_username|status    |
    |"James Anderson"|"available"|


  Scenario Outline: Finds Pets by status
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=<status>'
    When method get
    Then status 200
  Examples:
    |status   |
    |available|
    |pending  |
    |sold     |


  Scenario: Find pet by ID
    Given url 'https://petstore.swagger.io/v2/pet/'
    Given path petid
    When method get
    Then status 200
    And match response.id contains petid

  Scenario Outline: Updates a pet in the store with form data
    Given url 'https://petstore.swagger.io/v2/pet'
    Given path petid
    And form field name = <name>
    When method post
    Then status 200
    * def response1 = parseInt(response.message)
    And match response1 == petid
    Examples:
    |name  |
    |"Dogs"|

  Scenario: Deletes a pet
    Given url 'https://petstore.swagger.io/v2/pet/'
    Given path petid
    When method delete
    Then status 200
    * def response1 = parseInt(response.message)
    And match response1 == petid

  Scenario Outline: Place an order for a pet
    Given url 'https://petstore.swagger.io/v2/store/order'
    * def request1 = {"id":'#(orderid)',"petId":'#(petid)',"quantity":<quantity>,"shipDate":"2020-08-07T06:46:34.763Z","status":"placed","complete":true}    And request request1
    And request request1
    When method post
    Then status 200
    Examples:
      |quantity|
      |1       |
      |2       |
  Scenario: Find purchase order by ID
    Given url 'https://petstore.swagger.io/v2/store/order/'
    Given path orderid
    When method get
    Then status 200
    And match response.id == orderid

  Scenario: Delete purchase order by ID
    Given url 'https://petstore.swagger.io/v2/store/order/'
    Given path orderid
    When method delete
    Then status 200
    * def response1 = parseInt(response.message)
    And match response1 == orderid

  Scenario: Returns pet inventories by status
    Given url 'https://petstore.swagger.io/v2/store/inventory'
    When method get
    Then status 200
  Scenario Outline: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithArray'
    And request [{"id":1,"username":<username>,"firstName":<firstname>,"lastName":<lastName>,"email":<email>,"password":<password>,"phone":"string","userStatus":0}]
    When method post
    Then status 200
    And match response.message contains 'ok'
    Examples:
      | read('createuser.csv') |

  Scenario Outline: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithList'
    And request [{"id":<id>,"username":<username>,"firstName":<firstname>,"lastName":<lastname>,"email":<email>,"password":<password>,"phone":"string","userStatus":0}]
    When method post
    Then status 200
    And match response.message contains 'ok'
    Examples:
      | read('createuser.csv') |

  Scenario Outline: Get user by user name
    Given url 'https://petstore.swagger.io/v2/user/'
    Given path <username>
    When method get
    Then status 200
    And match response.username contains <username>
    Examples:
    Examples:
      |username  |
      |'Jame'    |

  Scenario Outline: Updated user
    Given url 'https://petstore.swagger.io/v2/user/'
    Given path <username>
    And request {"id":1,"username":<updated_username>,"firstName":"string","lastName":"string","email":"string","password":"string","phone":"string","userStatus":0}
    When method put
    Then status 200
    Examples:
    |username |updated_username|
    |'Jame'   |"James"         |

  Scenario Outline: Delete user
    Given url 'https://petstore.swagger.io/v2/user/'
    Given path <username>
    When method delete
    Then status 200
    Examples:
      | username |
      | 'James'  |

  Scenario Outline: Logs user into the system
    Given url 'https://petstore.swagger.io/v2/user/login?username=<username>&password=<password>'
    When method get
    Then status 200
    And match response.message contains 'logged in'
    Examples:
      | read('swaggerpet.csv') |

  Scenario: Logs out all current loggedin user
    Given url 'https://petstore.swagger.io/v2/user/logout'
    When method get
    Then status 200
    And match response.message contains 'ok'

  Scenario Outline: Create user
    Given url 'https://petstore.swagger.io/v2/user'
    And request {"id":<id>,"username":<username>,"firstName":<firstname>,"lastName":<lastName>,"email":"string","password":<password>,"phone":"string","userStatus":0}
    When method post
    Then status 200
    Examples:
      | read('createuser.csv') |


