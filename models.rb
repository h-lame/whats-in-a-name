DataMapper.setup(:default, settings.db_connection_string)

require 'models/person'

DataMapper.finalize
DataMapper.auto_upgrade!
