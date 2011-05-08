Feature: Source Control
  In order to build a project
  I want to interact with source control servers

  Scenario: Cloning a public GIT repository
    Given GIT repository "git@github.com:bradhe/dumbos.git"
    And integration name "Test Integration"
    When it is cloned
    Then there should be files in the "Test Integration" folder
    And it should contain a GIT repository
