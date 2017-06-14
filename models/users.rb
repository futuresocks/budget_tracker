require_relative '../db/Sql_Runner'
require "pry-byebug"

class User

  attr_accessor :id, :first_name, :last_name, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name'].capitalize
    @last_name = options['last_name'].capitalize
    @budget = options['budget'].to_f
  end

  def self.all
    sql = "SELECT * FROM users;"
    SqlRunner.run(sql).map { |options| User.new(options)}
  end

  def self.clear()
    sql = "DELETE FROM users;"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO users (first_name, last_name, budget) VALUES ('#{@first_name}', '#{@last_name}', #{@budget}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id'].to_i()
  end

  def full_name
    return "#{@first_name} #{@last_name}"
  end

  def update_budget(options)
    sql = "UPDATE users SET 
    budget = '#{options['budget'].to_f}'
    where id = '#{@id}';"
    SqlRunner.run(sql)
  end




end