require_relative '../db/Sql_Runner'
require "pry-byebug"

class Transaction

  attr_accessor :id, :merchant, :tag, :cost, :date_bought

  def initialize(options)
    @id = options['id'] if options ['id']
    @merchant = options['merchant'].split.map { |i| i.capitalize }.join(' ')
    @tag = options['tag'].capitalize
    @cost = options['cost'].to_f
    @date_bought = options['date_bought']
  end

  def save
    sql = "INSERT INTO transactions (merchant, tag, cost, date_bought) VALUES ('#{@merchant}', '#{@tag}', #{@cost}, '#{@date_bought}') RETURNING *;"
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
       cost = '#{options['cost']}',
       date_bought = '#{options['date_bought']}'
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

  def self.find_by_date(start_date, end_date)
    sql = "SELECT * FROM transactions WHERE '#{start_date}' <= date_bought AND date_bought < '#{end_date}';"
    SqlRunner.run(sql).map { |options| Transaction.new(options)}
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
