class Artist 
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(artist_to_compare)
    if artist_to_compare != nil
      (self.name() == artist_to_compare.name())
    else
      false
    end
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    if artist
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      Artist.new({:name => name, :id => id})
    else
      nil
    end
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def delete
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
        @name = attributes.fetch(:name)
        DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:album_name)) && (attributes.fetch(:album_name) !=nil)
      album_name = attributes.fetch(:album_name)
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

    @name = name
    DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
  end

 
end