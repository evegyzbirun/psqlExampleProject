require('spec_helper')
require 'album'

describe '#Album' do 
  
  describe('.all') do 
    it("returns an ampty array when there are no albums") do 
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do 
    it("saves an album") do 
      album1 = Album.new(name: "Giant",id: nil)
      album1.save()
      album2 = Album.new(name:"Blue",id: nil)
      album2.save()
      expect(Album.all).to(eq([album1, album2]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new(name: "Blue",id: nil)
      album2 = Album.new(name:"Blue",id: nil)
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new(name: "Giant",id: nil)
      album.save()
      album2 = Album.new(name:"Blue",id: nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new(name: "Giant",id: nil)
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end
  
  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new(name: "Giant",id: nil)
      album.save()
      album2 = Album.new(name:"Blue",id: nil)
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end
  describe('#delete') do
    it("deletes all albums_artists join relationships belonging to a deleted album") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      album.delete()
      results = DB.exec("SELECT * FROM albums_artists WHERE artist_id = #{artist.id};")
      expect(results.to_a).to(eq([]))
    end
  end
end