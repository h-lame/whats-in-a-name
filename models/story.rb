class Story
  include DataMapper::Resource
  property :id, Serial
  property :text, Text
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :person
end
