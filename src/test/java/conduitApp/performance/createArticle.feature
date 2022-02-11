Feature: Articles

Background: Definitions
    * url apiUrl
    

Scenario: Create and Delete Article
    * configure headers = {"Authorization": #('Token '+ __gatling.token)}
    Given path 'articles'
    #And request {"article": {"tagList": [],"title": "Deleted Articles","description": "aboust","body": "marking noting gettings"}}
    And request {"article": {"tagList": [],"title": "#(__gatling.Title)","description": "#(__gatling.Description)","body": "marking noting gettings"}}
    And header karate-name = "Title Request: " + __gatling.Title
    When method Post
    Then status 200
    * def articleId = response.article.slug

    * karate.pause(5000)
    
    Given path 'articles',articleId
    When method Delete
    Then status 200