require 'test_helper'

class PersonTest < WhatsInANameTest
  def setup
    @person = Person.new(:uid => '12345', :nickname => 'robo_dave', :name => 'Dave McTest', :created_at => Time.now)
  end

  def test_write_story_will_create_a_new_story_if_the_person_doesnt_have_one
    @person.write_story('The details of my name are quite inconsequential...')

    assert_not_nil @person.story
    assert_equal 'The details of my name are quite inconsequential...', @person.story.text

    assert_equal @person.story, Story.first(:person_id => @person.id)
  end

  def test_write_story_will_update_the_existing_story_if_the_person_already_has_one
    s = @person.story = Story.new(:text => 'It seemed funny, lol!')
    s.save
    @person.write_story('The details of my name are quite inconsequential...')

    assert_equal 'The details of my name are quite inconsequential...', @person.story.text
    assert_equal 'The details of my name are quite inconsequential...', s.text

    assert_equal @person.story, s
  end
end
