require ('sinatra')
require ('sinatra/contrib/all')
require ('pry-byebug')

require_relative ('models/users')
require_relative ('models/transactions')


get '/' do
  erb(:landing_page)
end

get '/budget' do
  @user = User.all
  @total = Transaction.total
  erb(:"budget/view")
end

post '/budget' do
  @user = User.new(params)
  @user.save
  @users = User.all
  @total = Transaction.total
  erb(:"budget/view")
end

get '/budget/edit' do
  @users = User.all
  erb(:"budget/edit")
end

post '/budget/edit' do
  @user = User.all.first
  @user.update_budget(params[:budget])
  erb(:"budget/amended")
end

get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total
  erb(:"transactions/index")
end

get '/transaction/new' do
  erb(:"transactions/new")
end

get '/transactions/search/:tag' do
  @transactions = Transaction.find(params[:tag])
  erb(:"tags/show")
end

get'/transactions/datesearch' do
  erb(:"transactions/datesearch")
end

post '/transactions/datesearch/results' do
  @transactions = Transaction.find_by_date(params[:first_date], params[:second_date])
  erb(:"transactions/find")
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find_id(params[:id])
  erb(:"transactions/edit")
end

get '/transactions/:id' do
  @transaction = Transaction.find_id(params[:id])
  erb(:"transactions/show")
end

post '/transactions/:id' do
  @transaction = Transaction.find_id(params[:id])
  @transaction.update(params)
  redirect to "/transactions/#{params[:id]}"
end

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save()
  @users = User.all
  @total = Transaction.total
  erb(:"transactions/created")
end

post '/transactions/:id/delete' do
  Transaction.find_id(params[:id]).delete
  redirect to "/transactions"
end
