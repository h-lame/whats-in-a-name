before '/tell-your-story' do
  redirect to('/') unless logged_in?
end

get '/tell-your-story' do
  erb :'stories/tell_your_story'
end

post '/tell-your-story' do
  if current_person.write_story(params[:story][:text])
    redirect to(story_path(current_person))
  else
    erb :'stories/tell_your_story'
  end
end

get '/:nickname' do
  @the_person = Person.first(:nickname => params[:nickname])
  erb :'stories/a_story'
end