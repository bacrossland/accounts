class User < ApplicationRecord
  has_many :transactions
  has_many :credits, -> { where(record_type: :credit) }, class_name: 'Transaction'
  has_many :debits, -> { where(record_type: :debit) }, class_name: 'Transaction'
  has_many :end_autopays, -> { where(record_type: :end_autopay) }, class_name: 'Transaction'
  has_many :start_autopays, -> { where(record_type: :start_autopay) }, class_name: 'Transaction'

  def balance
    (credits.sum(:amount) - debits.sum(:amount)).to_f
  end

end
