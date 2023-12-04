ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  Capybara.server_host = "0.0.0.0"
  Capybara.server_port = "3010"
  Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:3010"
end
