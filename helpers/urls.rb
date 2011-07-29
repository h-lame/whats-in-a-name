helpers do
  def root_path
    url('/')
  end

  def tell_your_story_path
    url('/tell-your-story')
  end

  def story_path(for_person)
    url("/#{for_person.nickname}")
  end
end
