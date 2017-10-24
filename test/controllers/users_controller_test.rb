require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    get users_path
    assert_response :success
  end

  test 'show' do
    get user_path(users(:one))
    assert_response :success
  end

end
