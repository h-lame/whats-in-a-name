helpers do
  def current_person
    @current_person ||= Person.get(session[:person_id]) if session[:person_id]
  end

  def logged_in?
    !current_person.nil?
  end
end
