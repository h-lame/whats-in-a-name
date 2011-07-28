$:.unshift File.dirname(__FILE__)

%w(oa-oauth datamapper dm-postgres-adapter dm-migrations erubis sinatra).each { |dependency| require dependency }

require 'environment'
require 'models'
require 'helpers'
require 'controllers'
