$:.unshift File.dirname(__FILE__)

%w(oa-oauth dm-core dm-postgres-adapter dm-migrations erubis sinatra).each { |dependency| require dependency }

require "environments/#{settings.environment}.rb"
require 'models'
require 'helpers'
require 'controllers'
