require ('sinatra')
require ('sinatra/contrib/all')
require ('pry-byebug')

require_relative ('models/users')
require_relative ('models/transactions')

get '/' do
  @users = User.all
  erb(:budget)
end

get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total
  erb(:transactions)
end

get '/transactions/new' do
  @transactions = Transaction.all
  erb(:new_transactions)
end
