require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do 
  @albums = Album.all
  erb(:albums)
end

get('/albums') do 
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  album = Album.new(name, nil)
  album.save()
  @albums = Album.all() 
  erb(:albums)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do 
  if params[:name] != ""
    @album = Album.find(params[:id].to_i())
    @abum.update(params[:name])
  end
  @albums = Album.allerb(:albums)
end
delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @albums.delete()
  @album = Album.all
  erb(:albums)
end
