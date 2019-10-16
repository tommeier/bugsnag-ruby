Feature: proxy configuration options

Scenario: Proxy settings are provided as configuration options
  Given I set environment variable "BUGSNAG_PROXY_HOST" to the current IP
  And I set environment variable "BUGSNAG_PROXY_PORT" to the mock API port
  And I set environment variable "BUGSNAG_PROXY_USER" to "tester"
  And I set environment variable "BUGSNAG_PROXY_PASSWORD" to "testpass"
  When I run the service "plain-ruby" with the command "bundle exec ruby configuration/proxy.rb"
  Then I wait to receive a request
  And the "proxy-authorization" header equals "Basic dGVzdGVyOnRlc3RwYXNz"
  And the event "metaData.proxy.user" equals "tester"

Scenario: Proxy settings are provided as the HTTP_PROXY environment variable
  Given I set environment variable "http_proxy" to the proxy settings with credentials "http://tester:testpass"
  When I run the service "plain-ruby" with the command "bundle exec ruby configuration/proxy.rb"
  Then I wait to receive a request
  And the "proxy-authorization" header equals "Basic dGVzdGVyOnRlc3RwYXNz"
  And the event "metaData.proxy.user" equals "tester"

Scenario: Proxy settings are provided as the HTTPS_PROXY environment variable
  Given I set environment variable "https_proxy" to the proxy settings with credentials "https://tester:testpass"
  When I run the service "plain-ruby" with the command "bundle exec ruby configuration/proxy.rb"
  Then I wait to receive a request
  And the "proxy-authorization" header equals "Basic dGVzdGVyOnRlc3RwYXNz"
  And the event "metaData.proxy.user" equals "tester"
