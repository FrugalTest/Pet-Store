Feature: Karate run

  Scenario: add a new pet to the store
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {"id": 1,"category": {"id": 1, "name": "Dog"},"name": "James","photoUrls": ["https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497&w=740&h=416"],"tags": [{"id": 0,"name": "dog1"}],"status": "available"}
    When method post
    Then status 200
    And match response.name contains 'James'
  Scenario: upload file
    Given url 'https://petstore.swagger.io/v2/pet/1/uploadImage'
# refer to the second scenario in this file for how to set the upload filename using the 'multipart file' syntax
    And multipart field file = read('maxresdefault.jpg')
    And header accept = 'application/json'
    And header Content-Type = 'multipart/form-data'
    When method post
    Then status 200
    And match response.message contains 'File uploaded'

  Scenario: Update an existing pet
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {"id": 1,"category": {"id": 1, "name": "Dog"},"name": "James Anderson","photoUrls": ["https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497&w=740&h=416"],"tags": [{"id": 0,"name": "dog1"}],"status": "available"}
    When method put
    Then status 200
    And match response.name contains 'James Anderson'
  Scenario: Finds Pets by status
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=available'
    When method get
    Then status 200

    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=pending'
    When method get
    Then status 200

    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=sold'
    When method get
    Then status 200

  Scenario: Find pet by ID
    Given url 'https://petstore.swagger.io/v2/pet/'
    Given path '/1'
    When method get
    Then status 200
    And match response.id contains 1

  Scenario: Updates a pet in the store with form data
    Given url 'https://petstore.swagger.io/v2/pet'
    Given path '/1'
    And form field name = 'Dog1'
    When method post
    Then status 200
    And match response.message contains '1'

  Scenario: Deletes a pet
    Given url 'https://petstore.swagger.io/v2/pet'
    Given path '/1'
    When method delete
    Then status 200
    And match response.message contains '1'

  Scenario: Place an order for a pet
    Given url 'https://petstore.swagger.io/v2/store/order'
    And request {"id":7,"petId":1,"quantity":1,"shipDate":"2020-08-07T06:46:34.763Z","status":"placed","complete":true}
    When method post
    Then status 200

  Scenario: Find purchase order by ID
    Given url 'https://petstore.swagger.io/v2/store/order'
    Given path '/7'
    When method get
    Then status 200
    And match response.id contains 7

  Scenario: Delete purchase order by ID
    Given url 'https://petstore.swagger.io/v2/store/order/'
    Given path '/7'
    When method delete
    Then status 200
    And match response.message contains '7'

  Scenario: Returns pet inventories by status
    Given url 'https://petstore.swagger.io/v2/store/inventory'
    When method get
    Then status 200
  Scenario: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithArray'
    And request [{"id":1,"username":"James1","firstName":"string1","lastName":"string1","email":"string1","password":"James1","phone":"string","userStatus":0}]
    When method post
    Then status 200
    And match response.message contains 'ok'

  Scenario: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithList'
    And request [{"id":1,"username":"James_Anderson","firstName":"string1","lastName":"string1","email":"string1","password":"James_Anderson","phone":"string","userStatus":0}]
    When method post
    Then status 200
    And match response.message contains 'ok'

  Scenario: Get user by user name
    Given url 'https://petstore.swagger.io/v2/user'
    Given path '/James_Anderson'
    When method get
    Then status 200
    And match response.username contains 'James_Anderson'

  Scenario: Updated user
    Given url 'https://petstore.swagger.io/v2/user'
    Given path '/James'
    And request {"id":1,"username":"James","firstName":"string","lastName":"string","email":"string","password":"string","phone":"string","userStatus":0}
    When method put
    Then status 200
  Scenario: Delete user
    Given url 'https://petstore.swagger.io/v2/user'
    Given path '/James'
    When method delete
    Then status 200
  Scenario: Logs user into the system
    Given url 'https://petstore.swagger.io/v2/user/login?username=James&password=James'
    When method get
    Then status 200
    And match response.message contains 'logged in'
  Scenario: Logs out all current loggedin user
    Given url 'https://petstore.swagger.io/v2/user/logout'
    When method get
    Then status 200
    And match response.message contains 'ok'
  Scenario: Create user
    Given url 'https://petstore.swagger.io/v2/user'
    And request {"id":1,"username":"James","firstName":"string","lastName":"string","email":"string","password":"James","phone":"string","userStatus":0}
    When method post
    Then status 200
