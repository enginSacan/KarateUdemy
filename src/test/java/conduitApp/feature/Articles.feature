Feature: Articles

Background: Definitions
    //Given url 'https://conduit.productionready.io/api/'
    //Given path 'users/login'
    //And request {"user": {"email": "mes@mes.com","password": "mes123"}}
    //When method Post
    //Then status 200
    //* def token = response.user.token

Scenario: Create New Articles
    
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Articles","description": "aboust","body": "marking noting gettings"}}
    When method Post
    Then status 200
    And match response.article.title == "Articles"

Scenario: Create and Delete Article
    
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Deleted Articles","description": "aboust","body": "marking noting gettings"}}
    When method Post
    Then status 200
    * def articleId = response.article.slug

    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == "Deleted Articles"

    
    Given path 'articles',articleId
    When method Delete
    Then status 200

    Given params {limit : 10, ofset : 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != "Deleted Articles"