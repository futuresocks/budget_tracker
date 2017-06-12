require_relative '../db/Sql_Runner'
require "pry-byebug"

class Transaction

  attr_accessor :id, :merchant, :tag, :cost

  def initialize(options)
    @id = options['id'] if options ['id']
    @merchant = options['merchant'].split.map { |i| i.capitalize }.join(' ')
    @tag = options['tag'].capitalize
    @cost = options['cost'].to_f
  end

  def save
    sql = "INSERT INTO transactions (merchant, tag, cost) VALUES ('#{@merchant}', '#{@tag}', #{@cost}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id'].to_i()
  end

  def delete
    sql = "DELETE FROM transactions WHERE transactions.id = #{@id};"
    SqlRunner.run(sql)
  end

  def update(options)
     sql = "UPDATE transactions SET
       merchant = '#{options['merchant']}',
       tag = '#{options['tag']}',
       cost = '#{options['cost']}'
       WHERE id = '#{options['id']}';"
     SqlRunner.run(sql)
   end

  def self.all
    sql = "SELECT * FROM transactions;"
    SqlRunner.run(sql).map { |options| Transaction.new(options)}
  end

  def self.find(search)
    sql = "SELECT * FROM transactions WHERE transactions.tag = '#{search}';"
    SqlRunner.run(sql).map { |options| Transaction.new(options)}
  end

  def self.find_id(search)
    sql = "SELECT * FROM transactions WHERE transactions.id = #{search};"
    Transaction.new(SqlRunner.run(sql).first)
  end

  def self.total
    sql = "SELECT * FROM transactions;"
    SqlRunner.run(sql).map{|transaction| transaction['cost'].to_f}.inject(0, :+)
  end

  def self.clear()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions where id = #{id}"
    SqlRunner.run(sql)
  end

end
