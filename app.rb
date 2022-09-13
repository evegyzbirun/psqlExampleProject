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