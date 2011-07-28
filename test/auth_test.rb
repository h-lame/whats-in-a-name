require 'test_helper'

class AuthTest < WhatsInANameTest
  def setup
    OmniAuth.config.add_mock(:twitter, {:uid => '12345', :user_info => {:nickname => 'robo_dave', :name => 'Dave McTest'}})
    app
  end

  def test_i_visit_the_site_and_after_authenticating_with_twitter_it_recognises_me
    visit '/'

    assert !page.has_content?('robo_dave')

    click_link 'create an account'

    assert '/', current_path

    stored_person = Person.first(:uid => '12345')

    assert_not_nil stored_person
    assert_equal 'robo_dave', stored_person.nickname
    assert_equal 'Dave McTest', stored_person.name

    assert page.has_content?('robo_dave')
  end
end
