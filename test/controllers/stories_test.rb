require 'test_helper'
require 'test/unit'
require 'rack/test'

set :environment, :test

class LoggedOutStoriesTest < WhatsInANameControllerTest
  def test_it_wont_let_me_find_out_how_to_tell_my_story
    @browser.get '/tell-your-story'
    assert @browser.last_response.redirect?
    assert_equal '/', last_redirect_path
  end

  def test_it_wont_let_me_actually_tell_my_story
    @browser.post '/tell-your-story', :story => {:text => 'Wooooo'}
    assert @browser.last_response.redirect?
    assert_equal '/', last_redirect_path
    assert_equal 0, Story.count
  end
end

class LoggedInStoriesTest < WhatsInANameControllerTest
  # setup is called before add_setup_hook blocks are run.
  # so we need to use @browser in our own add_setup_hook :|
  add_setup_hook do |testcase|
    testcase.instance_eval do
      @me = Person.create(:uid => '12345', :nickname => 'robo_dave', :name => 'Dave McTest', :created_at => Time.now - (3 * 60 * 60 * 24))
      OmniAuth.config.add_mock(:twitter, {:uid => '12345', :user_info => {:nickname => 'robo_dave', :name => 'Dave McTest'}})
      @browser.get '/auth/twitter'
      @browser.follow_redirect!
    end
  end

  def test_it_will_let_me_find_out_how_to_tell_my_story
    @browser.get '/tell-your-story'
    assert @browser.last_response.ok?
  end

  def test_it_will_let_me_actually_tell_my_story
    @browser.post '/tell-your-story', :story => {:text => 'Wooooo'}
    assert @browser.last_response.redirect?
    assert_equal "/#{@me.nickname}", last_redirect_path
    assert_equal 1, Story.count
    assert_not_nil @me.story
  end
end
