Feature: SignUp new user

Background: Preconditions
    * def dataGenerator = Java.type("helpers.DataGenerator")
    Given url apiUrl

Scenario: New User Sign Up
   
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUsername()

    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": #(randomEmail),
            "password": "mes123",
            "username": #(randomUserName)
        }
    }
    """
    When method Post
    Then status 200
Scenario Outline: Check login error messages
   
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUsername()

    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": "<email>",
            "password": "<password>",
            "username": "<username>"
        }
    }
    """
    When method Post
    Then status 200
    And match response == errorResponse
    
    Examples:
        |email           |password  |username   |errorResponse  |
        | #(randomEmail) |  mes123  |  mes      |   jsonobject  |