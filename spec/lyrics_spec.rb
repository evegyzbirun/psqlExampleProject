# require('spec_helper')
require 'song'
require 'album'
require 'lyrics'

describe '#Lyrics' do

  before(:each) do
    Lyrics.clear()
    @album = Album.new("Giant Steps", nil)
    @album.save()
    @song = Song.new("Naima", @album.id, nil)
    @song.save()

    @attributes = {
      lyrics: "Oh yeah! It's a great song! This song is great!", 
      album_id:  @album.id, 
      song_id: @song.id, 
      id: nil
    }

    @attributes2 = {
      lyrics: "Hey, it's PJ, get on the dance floor!!", 
      album_id: @album.id, 
      song_id: @song.id, 
      id: nil
    }

    @lyric = Lyrics.new(@attributes)
    @lyric.save()
    @lyric2 = Lyrics.new(@attributes)
    @lyric2.save()
  end

  describe('#==') do
    it("is the same lyric if it has the same attributes as another song") do
      expect(@lyric).to(eq(@lyric2))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      expect(Lyrics.all).to(eq([@lyric, @lyric2]))
    end
  end

  describe('.clear') do
    it("clears all lyrics") do
      Lyrics.clear()
      expect(Lyrics.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a lyrics by id") do
      expect(Lyrics.find(@lyric.id)).to(eq(@lyric))
    end
  end

  describe('#update') do
    it("updates an lyric by id") do
      @lyric.update("Hey, it's PJ, get on the dance floor!!", @song.id, @album.id)
      expect(@lyric.lyrics).to(eq("Hey, it's PJ, get on the dance floor!!"))
    end
  end
  
  describe('#delete') do
    it("deletes an lyrics by id") do
      @lyric.delete()
      expect(Lyrics.all).to(eq([@lyric2]))
    end
  end

end

