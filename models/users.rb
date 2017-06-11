require_relative '../db/Sql_Runner'
require "pry-byebug"

class User

  attr_accessor :id, :first_name, :last_name, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @budget = options['budget'].to_f
  end

  def self.all
    sql = "SELECT * FROM users;"
    SqlRunner.run(sql).map { |options| User.new(options)}
  end

  def save
    sql = "INSERT INTO users (first_name, last_name, budget) VALUES ('#{@first_name}', '#{@last_name}', #{@budget}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id'].to_i()
  end

  def full_name
    return "#{@first_name} #{@last_name}"
  end

  def purchase_all
    sql = "SELECT transactions.cost FROM transactions;"
    @budget -= SqlRunner.run(sql).map{|transaction| transaction['cost'].to_f}.inject(0, :+)
  end


end