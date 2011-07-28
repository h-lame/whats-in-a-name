ENV['RACK_ENV'] = 'test'
require './whats-in-a-name'  # <-- your sinatra app
require 'capybara'
require 'capybara/dsl'
gem 'minitest'
require 'test/unit'
require 'minitest/pride'
require 'database_cleaner'
DatabaseCleaner.strategy = :transaction

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

class WhatsInANameTest < Test::Unit::TestCase
  include Capybara::DSL
  def app
    @app = Capybara.app = Sinatra::Application.new
  end

  add_setup_hook do
    DatabaseCleaner.start
  end

  add_teardown_hook do
    DatabaseCleaner.clean
  end
end
