ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'stripe_mock'
require "minitest/mock"

# Start a StripeMock server
require 'thin'
#StripeMock.kill_server(StripeMock.default_server_pid_path)
StripeMock.spawn_server
# This next line prevents ActiveRecord::StatementInvalid: PG::ConnectionBad: PQsocket() can't get socket descriptor
ActiveRecord::Base.connection.reconnect!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
