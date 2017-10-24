class Transaction < ApplicationRecord
  belongs_to :transaction_log
  belongs_to :user

  extend Enumerize

  enumerize :record_type, :in => [ :debit, :credit, :start_autopay, :end_autopay ]

  def self.translate_record_type(int)
    case int
      when 0
        :debit
      when 1
        :credit
      when 2
        :start_autopay
      when 3
        :end_autopay
      else
        'Not a valid record type'
    end
  end
end
