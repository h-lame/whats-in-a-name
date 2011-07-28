get '/' do
  if logged_in?
    erb :'root/hi_there'
  else
    erb :'root/join_in'
  end
end
