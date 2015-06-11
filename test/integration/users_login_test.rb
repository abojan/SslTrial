require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ania)
	end

	test "login with invalid information" do 
		get login_path
		assert_template 'sessions/new'
		post login_path, session: { email: " ", password: " "}
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information" do
		get login_path
		post login_path, session: { email: @user.email, password: "example"}
		assert is_logged_in?
		assert_not flash.empty?
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		delete logout_path
		assert_not is_logged_in?
		assert_not flash.empty?
		assert_redirected_to root_url
		delete logout_path
		follow_redirect!
		assert_template 'pages/home'
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, 			count: 0
	end
end
