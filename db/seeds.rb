# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

datafile = "#{Rails.root}/db/seed_data/data.dat"

if File.exist?(datafile)
  data = File.binread(datafile)
else
  puts "ERROR: The #{datafile} file is missing. Can not seed database. Please add the #{datafile} and try again."
  exit(false)
end

mainframe = data[0..3]

unless mainframe == 'MPS7'
  puts "ERROR: The #{datafile} can not be loaded. The header code of #{mainframe} is invalid."
  exit(false)
end

version = data[4].unpack('c').first
num_records = data[5..8].unpack('N').first

log = TransactionLog.where(name: mainframe, version: version, record_count: num_records)

unless log.blank?
  puts "INFO: The #{datafile} has already been loaded. Not loading it again. If you believe you received this message by mistake, run rails db:reset."
  exit(true)
end

TransactionLog.transaction do
  begin
    start_byte = 9
    progressbar = ProgressBar.create(title: 'Loading Transactions', format: '%t |%B| %p%%', total: num_records)

    log = TransactionLog.create(name: mainframe, version: version, record_count: num_records)
    1.upto(num_records) do

      record_code = data[start_byte].unpack('c').first
      record_type = Transaction.translate_record_type(record_code)
      time_start = start_byte + 1
      time_stop = start_byte + 4
      user_start = start_byte + 5
      user_stop = start_byte + 12
      amount_start = start_byte + 13
      amount_stop = start_byte + 21

      time = Time.at(data[time_start..time_stop].unpack('N').first)
      user = data[user_start..user_stop].unpack('L!>').first

      rec_user = User.find_or_create_by(username: user)


      Transaction.transaction do
        if [:debit,:credit].include?(record_type)
          amount = data[amount_start..amount_stop].unpack('G').first
          Transaction.create(transaction_log_id: log.id, user_id: rec_user.id, record_type: record_type, processed_at: time, amount: amount)
          start_byte += 21
        elsif [:start_autopay,:end_autopay].include?(record_type)
          Transaction.create(transaction_log_id: log.id, user_id: rec_user.id, record_type: record_type, processed_at: time)
          start_byte += 13
        else
          raise "ERROR: The record code #{record_code} is not valid."
        end
      end
      progressbar.increment
    end

    raise "ERROR: The database record count of #{Transaction.count} doesn't match the #{datafile} record count of #{num_records}" unless Transaction.count == num_records

  rescue => e
    puts e.message
    raise ActiveRecord::Rollback
  end
end