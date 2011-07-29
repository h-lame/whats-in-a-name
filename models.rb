DataMapper.setup(:default, settings.db_connection_string)

require 'models/person'
require 'models/story'

DataMapper.finalize
DataMapper.auto_upgrade!
