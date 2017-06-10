require_relative '../db/Sql_Runner'
require "pry-byebug"

class Transaction

  attr_accessor :id, :merchant, :tag, :cost

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @merchant = options['merchant']
    @tag = options['tag']
    @cost = options['cost'].to_i
  end

  def save
    sql = "INSERT INTO transactions (merchant, tag, cost) VALUES ('#{@merchant}', '#{@tag}', #{@cost}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id'].to_i()
  end

  def self.all
    sql = "SELECT * FROM transactions;"
    SqlRunner.run(sql).map { |options| Transaction.new(options)}
  end

  def self.find(tag)
    sql = "SELECT * FROM transactions WHERE tag=#{tag};"
    Transaction.new(SqlRunner.run(sql).first)
  end




end
