Feature: Plain ignore classes

Scenario Outline: An errors class is in the ignore_classes array
  When I run the service "plain-ruby" with the command "bundle exec ruby ignore_classes/<state>.rb"
  And I wait for 1 second
  Then I should receive 0 requests

  Examples:
  | state     |
  | unhandled |
  | handled   |
