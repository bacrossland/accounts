class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :transaction_log, index: true
      t.belongs_to :user, index: true
      t.string :record_type, limit: 13
      t.datetime :processed_at
      t.decimal :amount, precision: 53, scale: 17
      t.timestamps
    end
  end
end
