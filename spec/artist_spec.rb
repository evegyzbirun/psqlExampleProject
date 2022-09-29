require('spec_helper')
require('artist')

describe('#update') do
  it("adds an album to an artist") do
    artist = Artist.new({name: "John Coltrane", id: nil})
    artist.save()
    album = Album.new({name: "A Love Supreme", id: nil})
    album.save()
    artist.update({album_name: "A Love Supreme"})
    expect(artist.albums).to(eq([album]))
  end
end

describe('#delete') do
  it("deletes all albums_artists join relationships belonging to a deleted artist") do
    artist = Artist.new({:name => "John Coltrane", :id => nil})
    artist.save()
    album = Album.new({:name => "A Love Supreme", :id => nil})
    album.save()
    artist.update({:album_name => "A Love Supreme"})
    artist.delete()
    results = DB.exec("SELECT * FROM albums_artists WHERE album_id = #{album.id};")
    expect(results.to_a).to(eq([]))
  end
end