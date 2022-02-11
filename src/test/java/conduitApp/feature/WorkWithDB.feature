Feature: Work with DB

Background: Preconditions
    * def dbHandler = Java.type('helpers.DbHandler') 
Scenario: Seed database with a new Job
    * eval dbHandler.addNewJobWithName("QA2")

Scenario: Get Job Level
    * def level =  dbHandler.getMinAndMaxLevelsForJob("QA2")
    * print level.minLvl
    * print level.maxLvl