class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find params[:id]
  end

  def summary
    @user = User.where(username: 2456938384156277127).first
    @credit_total = Transaction.credit.sum(:amount)
    @debit_total = Transaction.debit.sum(:amount)
    @start_autopay_count = Transaction.start_autopay.count
    @end_autopay_count = Transaction.end_autopay.count
  end

end
