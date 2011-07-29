ENV['RACK_ENV'] = 'test'
require './whats-in-a-name'  # <-- your sinatra app
require 'capybara'
require 'capybara/dsl'
require 'rack/test'
gem 'minitest'
require 'test/unit'
require 'minitest/pride'
require 'database_cleaner'

set :environment, :test

# Until https://github.com/intridea/omniauth/pull/411 is fixed
class Hash
  def stringify_keys
    dup.stringify_keys!
  end
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete(key)
    end
    self
  end
end

# Until https://github.com/bmabey/database_cleaner/commit/44cd4b611eea526bc47750cd5a7fefa0877ae0e4 is released
class String
  def compress_lines
    self
  end
end

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

class WhatsInANameTest < Test::Unit::TestCase
  add_setup_hook do
    DatabaseCleaner.start
  end

  add_teardown_hook do
    DatabaseCleaner.clean
  end
end

class WhatsInANameAppTest < WhatsInANameTest
  include Capybara::DSL
  def app
    @app = Capybara.app = Sinatra::Application.new
  end

  add_setup_hook do |test_case|
    test_case.app
  end
end

class WhatsInANameControllerTest < WhatsInANameTest
  def last_redirect_path
    s, ui, h, p, r, path, o, query, fragment = *URI.split(@browser.last_response.location)
    [path, query ? "?#{query}" : nil, fragment ? "##{fragment}" : nil].join
  end

  add_setup_hook do |test_case|
    test_case.instance_variable_set(:'@browser', Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application)))
  end
end
