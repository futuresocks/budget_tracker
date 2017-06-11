require ('sinatra')
require ('sinatra/contrib/all')
require ('pry-byebug')

require_relative ('models/users')
require_relative ('models/transactions')

get '/' do
  @users = User.all
  @total = Transaction.total
  erb(:budget)
end

get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total
  erb(:transactions)
end

get '/transaction/new' do
  erb(:new_transaction)
end

get '/transactions/:tag' do
  @transactions = Transaction.find(params[:tag])
  erb(:show_tag)
end

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  @users = User.all
  @total = Transaction.total
  erb(:transaction_created)
end
