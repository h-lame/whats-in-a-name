require "environments/#{settings.environment}.rb"
Tilt.register :erb, Tilt[:erubis]
set :erubis, :escape_html => true