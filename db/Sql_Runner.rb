require 'pg'

class SqlRunner

  def self.run(sql)
    db = PG.connect({
      dbname: 'budget',
      host: 'localhost'
      })
    result = db.exec(sql)
    db.close
    return result
  end
end