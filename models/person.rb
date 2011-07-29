class Person
  include DataMapper::Resource
  property :id, Serial
  property :uid, String
  property :name, String
  property :nickname, String
  property :created_at, DateTime

  has 1, :story

  def write_story(text)
    s = self.story
    s = self.story = Story.new if s.nil?
    s.text = text
    s.save
  end
end
