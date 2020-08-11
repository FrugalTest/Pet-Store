How would you run these tests in parallel?
 Ans. Used Karate parallel function to define the threadcount for feature file defined in build path of pom.xml
​
  @KarateOptions(tags = {"~@ignore"})
 public class Karaterunner {
    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 2, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
 }
 Thread count = 2 , report target folder = target/surefire-reports 
​
 Can you call one scenario from another - to reuse implementation ?
 Ans. In same feature file we cannot but defining a scenario in feature file and then fetching it is possible
  
  We implement it in Addpet.feature and  our main feature file Swagger_Petstore.feature file 
Swagger_Petstore.feature
​
  Scenario: upload file
    * def response1 = call read('classpath:Addpet.feature')
    using response for petid
​
    for further scenarios we have defined a karate-config.js file for global variables petid and orderid.
    karate.callSingle('classpath:Addpet.feature');
    feature file is call one time only.
    orderid is defined for a randomvalue that is allocated for one time only using random.js else for every call to karate-config.js the value would change.
​
Demo an example of data driving the test using Scenario Outline
 Ans. Scenario Outline is used in many scenarios defined in Swagger_Petstore.feature
      
      Scenario Outline: Update an existing pet
      Scenario Outline: Finds Pets by status
​
      and more.
In addition, load data from an external file and use it in test
 Ans. csv files are used to get the data.
      
    Scenario Outline: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithArray'
    And request [{"id":1,"username":<username>,"firstName":<firstname>,"lastName":<lastName>,"email":<email>,"password":<password>,"phone":"string","userStatus":0}]
    When method post
    Then status 200
    And match response.message contains 'ok'
    Examples:
      | read('createuser.csv') |
​
​
    Feature: Add Pet
    
    Scenario Outline: add a new pet to the store
    Given url 'https://petstore.swagger.io/v2/pet'
    And request {"id": <userid>,"category": {"id": <petid>, "name": "Dog"},"name": <username>,"photoUrls": [<photourl>],"tags": [{"id": 0,"name": "dog1"}],"status": <status>}
    When method post
    Then status 200
    And match response.name contains 'James'
    Examples:
    | read('swaggerpet.csv') |
​
Finally, can you show how to run these tests from command-line?
​
 Ans. Refer file Run_Karate_Test_from_command_line.docx for detailed explaination and screenshots of test run
​
​
For report target\surefire-reports
