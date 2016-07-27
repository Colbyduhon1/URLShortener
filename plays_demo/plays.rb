require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute("select * from plays where title = '#{title}'")
    Play.new(play.first)
  end

  def self.find_by_playwright(name)
    playwright_id = Playwright.find_by_name(name).id
    plays = PlayDBConnection.instance.execute("select * from plays where playwright_id = #{playwright_id}")
    plays.map { |play| Play.new(play)}
  end
end

class Playwright

  attr_reader :id, :name, :birth_year

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def self.all
    wrights = PlayDBConnection.instance.execute('select * from playwrights')
    wrights.map { |playwr| Playwright.new(playwr)}
  end

  def self.find_by_name(name)
    wrights = PlayDBConnection.instance.execute("Select * from playwrights where name='#{name}'")
    Playwright.new(wrights[0])
  end

  def new
    Playwright.new
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?

      SQL
  end

  def get_plays
    raise "#{self} doesn't exist" unless @id
    # PlayDBConnection.instance.execute("Select * from plays where playwright_id = #{@id}")
    Play.find_by_playwright(self.name)
  end


end
