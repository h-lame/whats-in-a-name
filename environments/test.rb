set :db_connection_string, 'postgres://localhost/whats_in_a_name_test'

set :twitter, {:consumer_key => 'YOUR KEY', :consumer_secret => 'YOUR SECRET'}
OmniAuth.config.test_mode = true
