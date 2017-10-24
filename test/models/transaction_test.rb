require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test 'class method translate_record_type returns Symbol when a correct value is passed' do
    assert_instance_of Symbol, Transaction.translate_record_type(0)
  end

  test 'class method translate_record_type returns String when a incorrect value is passed' do
    assert_instance_of String, Transaction.translate_record_type(5)
  end
end
