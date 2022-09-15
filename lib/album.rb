class Album
  attr_reader :id, :name
  attr_accessor :name
  @@albums = {}
  @@albums_sold = {}
  @@total_rows = 0

  def initialize(name, id)
    @name = name
    @id = id || @@total_rows += 1
  end

  def self.all
    @@albums.values().sort { |a, b| a.name.downcase <=> b.name.downcase }
  end

  def self.all_sold
    @@albums_sold.values().sort { |a, b| a.name.downcase <=> b.name.downcase }
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name)
    self.name = name
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def delete()
    @@albums.delete(self.id)
  end

  def self.search_name(name)
    @@albums.values().select { |album| /#{name}/i.match? album.name }
  end

  def buy_album()
    @@albums.delete(self.id)
    @@albums_sold[self.id] = Album.new(self.name, self.id)
  end
end
 