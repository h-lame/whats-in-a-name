set :db_connection_string, ENV['DATABASE_URL']

set :twitter, {:consumer_key => ENV['TWITTER_CONSUMER_KEY'], :consumer_secret => ENV['TWITTER_CONSUMER_SECRET']}