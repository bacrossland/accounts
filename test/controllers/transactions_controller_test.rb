require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get transactions_path
    assert_response :success
  end

  test 'show' do
    get transaction_path(transactions(:one))
    assert_response :success
  end
end
