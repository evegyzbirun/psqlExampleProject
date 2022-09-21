class Lyrics
  attr_reader :id
  attr_accessor :lyrics, :song_id , :album_id

  @@lyrics = {}
  @@total_rows = 0

  def initialize(attributes)
    @lyrics = attributes.fetch(:lyrics)
    @song_id = attributes.fetch(:song_id)
    @album_id = attributes.fetch(:album_id)
    @id = attributes.fetch(:id) || @@total_rows += 1
  end

  def self.all 
    @@lyrics.values
  end

  def save 
    @@lyrics[self.id] = Lyrics.new(:lytics => self.lyrics, :album_id=>self.album_id , :song_id => self.song_id,:id => self.id)
  end

  def self.find(id)
    @@lyrics[id]
  end

  def update(lyrics, song_id , album_id)
    self.lyrics = lyrics
    self.song_id = song_id
    self.album_id = album_id
    @@lyrics[self.id] = Lyrics.new(:lytics => self.lyrics, :album_id => self.album_id, :song_id => self.song_id, :id => self.id)
  end

  def delete 
    @@lyrics.delete(self.id)
  end

  def self.clear
    @@lyrics = {}
  end

  def song
    Song.find(self.song_id)
  end

  def album
    Album.find(self.album_id)
  end

end
