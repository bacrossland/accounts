require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'balance returns value as a Float' do
    user = users(:one)
    assert_instance_of Float, user.balance
  end
end
