class Transaction < ApplicationRecord
  belongs_to :transaction_log
  belongs_to :user

  extend Enumerize

  enumerize :record_type, :in => [ :debit, :credit, :start_autopay, :end_autopay ]

  scope :credit, -> { where(record_type: :credit) }
  scope :debit, -> { where(record_type: :debit) }
  scope :end_autopay, -> { where(record_type: :end_autopay) }
  scope :start_autopay, -> { where(record_type: :start_autopay) }

  # Translates the record_code to human readable format.
  # Takes FixNum and returns Symbol or String.
  def self.translate_record_type(record_code)
    case record_code
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
