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
  if params["search"]
    @albums = Album.search_name(params[:search])
  else
    @albums = Album.all
    @albums_sold = Album.all_sold()
  end
  erb(:albums)
end

#if /albums?search=(params[:name]) == name to one of names in the list
# ==
#/albums/id

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
  @albums = Album.all() 
  @albums_sold = Album.all_sold()
  erb(:albums)
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
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

