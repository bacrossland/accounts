class CreateTransactionLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :transaction_logs do |t|
      t.string :name, limit: 4
      t.string :version, limit: 11
      t.integer :record_count, limit: 4
      t.text  :contents
      t.timestamps
    end
  end
end
