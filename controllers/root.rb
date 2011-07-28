get '/' do
  if logged_in?
    "<h1>Hi, #{current_person.nickname}</h1>"
  else
    '<a href="/sign_up">create an account</a> or <a href="/sign_in">sign in with Twitter</a>'
  end
end
