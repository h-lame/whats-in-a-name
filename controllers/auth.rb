use OmniAuth::Strategies::Twitter, settings.twitter[:consumer_key], settings.twitter[:consumer_secret]

get '/auth/:name/callback' do
  auth = request.env["omniauth.auth"]
  person = Person.first_or_create({ :uid => auth["uid"]}, {
    :uid => auth["uid"],
    :nickname => auth["user_info"]["nickname"],
    :name => auth["user_info"]["name"],
    :created_at => Time.now })
  session[:person_id] = person.id
  redirect '/'
end

# any of the following routes should work to sign the user in:
# /sign_up, /signup, /sign_in, /signin, /log_in, /login
["/sign_in/?", "/signin/?", "/log_in/?", "/login/?", "/sign_up/?", "/signup/?"].each do |path|
  get path do
    redirect '/auth/twitter'
  end
end

# either /log_out, /logout, /sign_out, or /signout will end the session and log the user out
["/sign_out/?", "/signout/?", "/log_out/?", "/logout/?"].each do |path|
  get path do
    session[:person_id] = nil
    redirect '/'
  end
end
