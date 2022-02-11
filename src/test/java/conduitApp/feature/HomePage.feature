Feature: Tests for the home page.

Background: Definitions
    Given url apiUrl
Scenario: Get All Tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains 'welcome'
    And match response.tags contains ['codebaseShow','introduction']
    And match response.tags !contains 'cars'
    And match response.tags == "#array"
    And match each response.tags == "#string"
Scenario: Get 10 Articles from the page.
   # Given param limit = 10
   # Given param offset = 0
    * def timeValidator = read("classpath:helpers/timeValidator.js")
    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == "#[3]" // size of an array
    And match response.articlesCount == 3
    And match response..bio contains null // search till the bio no matter where it is
    And match each response..bio == "##string" // optional tag it ca be null or not present
    And match each response.articles ==
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            },
            "favoritesCount": "#number",
            "favorited": "#boolean"
        }
    """
Scenario: Conditional Logic
    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]
    #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

Scenario: Retry Call
    # * configure retry = {count:10, interval:5000}
    
    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    # And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

Scenario: Sleep Call
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    * eval sleep (5000)
    Then status 200
