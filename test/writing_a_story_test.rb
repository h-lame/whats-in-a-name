require 'test_helper'

class WritingAStoryTest < WhatsInANameAppTest
  def setup
    @me = Person.create(:uid => '12345', :nickname => 'robo_dave', :name => 'Dave McTest', :created_at => Time.now - (3 * 60 * 60 * 24))
    OmniAuth.config.add_mock(:twitter, {:uid => '12345', :user_info => {:nickname => 'robo_dave', :name => 'Dave McTest'}})
  end

  def test_after_authenticating_i_am_asked_to_write_a_story
    visit '/'
    click_link 'sign in with Twitter'

    click_link 'tell the story of your name'

    assert_equal '/tell-your-story', current_path

    assert page.has_content? 'Hi, robo_dave'

    fill_in "I'm called this because", :with => 'The story of my name is quite inconsequential...'

    click_button 'The end.'

    assert_equal '/robo_dave', current_path

    assert page.has_content? 'Hi, my real name is Dave McTest'
    assert page.has_content? "But on Twitter I'm called robo_dave"
    assert page.has_content? 'The story of my name is quite inconsequential...'

    assert_not_nil @me.story
    assert_equal 'The story of my name is quite inconsequential...', @me.story.text
  end
end