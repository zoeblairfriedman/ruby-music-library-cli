require 'pry'

class Song
attr_accessor :name 
attr_reader :artist, :genre

@@all = []

def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
end

def artist=(artist)
     @artist = artist
     artist.add_song(self)
end

def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
        genre.songs << self 
    end 
end

def self.all
    @@all
end

def save
    @@all << self
end

def self.destroy_all
    self.all.clear
end

def self.create(*args)
    new_addition = Song.new(*args)
    self.all << new_addition
    new_addition
end


def self.find_by_name(name)
    self.all.find {|ele| ele.name == name}
end

def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
        self.create(name)
    else
        self.find_by_name(name)
    end
end

def self.new_from_filename(file_name)
    title = file_name.split(" - ")[1]
    new_artist = Artist.find_or_create_by_name(file_name.split(" - ")[0])
    genre_string = file_name.split(" - ")[2].gsub(".mp3", "")
    new_genre = Genre.find_or_create_by_name(genre_string)
    new_song = Song.new(title, new_artist, new_genre)
    # binding.pry
end

def self.create_from_filename(file_name)
   new_song = self.new_from_filename(file_name)
   new_song.save
end

end

