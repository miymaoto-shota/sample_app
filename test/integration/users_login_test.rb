require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tester)
  end

  test 'Login with invalid information' do
    # ログイン失敗時のflashメッセージが表示されているか
    # 別画面に遷移したらflashメッセージが削除されているか
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'Login success and change view Test' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0 # ログインしたらログインパスが無くなっているか
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'Logout Test' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }

    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path,      count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'Login with remembering' do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test 'Login without remembering' do
    # save cookie and login
    log_in_as(@user, remember_me: '1')
    delete logout_path

    # delete cookie and login
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
