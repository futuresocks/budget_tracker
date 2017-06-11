require_relative '../models/transactions'
require_relative '../models/users'
require "pry-byebug"

user1 = User.new({
  'first_name' => "Colin",
  'last_name' => "Bell",
  'budget' => 500
})

transaction1 = Transaction.new({
  'merchant' => "Forbidden Planet",
  'tag' => "comics",
  'cost' => 100
})

transaction2 = Transaction.new({
  'merchant' => "Paesano",
  'tag' => "pizza",
  'cost' => 7
})


transaction3 = Transaction.new({
  'merchant' => "Shilling Brewing Co",
  'tag' => "beer",
  'cost' => 1.30
})

User.clear
Transaction.clear
user1.save
transaction1.save
transaction2.save
transaction3.save

binding.pry
nil
