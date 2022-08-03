require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    # Home
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href= ?]', root_path, count: 2
    assert_select 'a[href= ?]', help_path
    assert_select 'a[href= ?]', about_path
    assert_select 'a[href= ?]', contact_path
    assert_select 'a[href= ?]', signup_path

    assert_select 'title', full_title('Home')

    # help
    get help_path
    assert_select 'title', full_title('Help')

    # about
    get about_path
    assert_select 'title', full_title('About')

    # contact
    get contact_path
    assert_select 'title', full_title('Contact')

    # sign up
    get signup_path
    assert_select 'title', full_title('SignUp')
  end
end
