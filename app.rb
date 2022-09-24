require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')


get('/') do 
  @albums = Album.all
  @albums_sold = Album.all_sold()
  erb(:albums)
end

get('/albums') do 
  if params["search"]
    @albums = Album.search_name(params[:search])
  else
    @albums = Album.all
    @albums_sold = Album.all_sold()
  end
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/info') do 
  erb(:info_album)
end

post('/albums') do
  name = params[:album_name]
  album = Album.new(name, nil)
  album.save()
  redirect to('/albums')
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

# we are working on this one 
post('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.buy_album()
  @albums_sold = Album.all_sold()
  @albums = Album.all() 
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  if params[:name] != ""
    @album = Album.find(params[:id].to_i())
    @album.update(params[:name])
  end
    @albums = Album.all
    @albums_sold = Album.all_sold()
    erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  @albums_sold = Album.all_sold()
  erb(:albums)
end

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  if params[:name] != ""
    song = Song.find(params[:song_id].to_i())
    song.update(params[:name], @album.id)
  end
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


