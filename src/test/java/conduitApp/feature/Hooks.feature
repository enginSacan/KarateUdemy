Feature: Hooks

Background: Hooks
    * def result = call read('classpath:helpers/Dummy.feature')
    * def username = result.username

    #* def result = callonce read('classpath:helpers/Dummy.feature') //sadece bir kere çağırmak için

    # after hooks
    # * configure afterFeature = function() {karate.call('classpath:helpers/Dummy.feature')}
    # * configure afterScenario = function() {karate.call('classpath:helpers/Dummy.feature')}
Scenario: Scenario 1
    * print username
    * print "This is scenario 1"
Scenario: Scenario 2
    * print username
    * print "This is scenario 2"