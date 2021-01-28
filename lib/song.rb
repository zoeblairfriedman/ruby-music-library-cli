class Song
attr_accessor :name 
attr_reader :artist, :genre

@@all = []

def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
end

def artist=(artist)
    if artist != nil
     @artist = artist
     artist.add_song(self)
    end
end

def genre=(genre)
    @genre = genre
    if genre!=nil && !genre.songs.include?(self)
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

def self.create(name)
    new_addition = Song.new(name)
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

end