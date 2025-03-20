Feature: Say hello
  Scenario: Some name yields successful execution
      Given that the user is called "John"
       Then the execution succeeds

  Scenario: User's name is used in the greeting
      Given that the user is called "World"
       Then the greeting will say "Hello, World!"

  Scenario: No name provided yields error
      Given no username provided
       Then the execution fails

  Scenario: No name provided prints usage
      Given no username provided
       Then the output prints the usage