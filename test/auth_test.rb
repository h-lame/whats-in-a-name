require 'test_helper'

class AuthTest < WhatsInANameTest
  def setup
    OmniAuth.config.add_mock(:twitter, {:uid => '12345', :user_info => {:nickname => 'robo_dave', :name => 'Dave McTest'}})
    app
  end

  def test_i_visit_the_site_and_after_authenticating_with_twitter_it_stores_my_details_in_the_db
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

  def test_i_previously_visited_the_site_and_when_i_do_so_again_authenticating_with_twitter_doesnt_duplicate_my_details
    Person.create(:uid => '12345', :nickname => 'robo_dave', :name => 'Dave McTest', :created_at => Time.now - (3 * 60 * 60 * 24))

    visit '/'

    assert !page.has_content?('robo_dave')

    click_link 'sign in with Twitter'

    assert '/', current_path

    assert page.has_content?('robo_dave')

    assert_equal 1, Person.count(:uid => '12345')
  end
end
