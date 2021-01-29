require 'pry'

class Artist
    attr_accessor :name, :songs
    extend Concerns::Findable

    
    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
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
        new_addition = Artist.new(name)
        self.all << new_addition
        new_addition
    end

    def add_song(song)
        if song.artist == nil
        song.artist = self
        end
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        self.songs.collect{|song| song.genre}.uniq
    end

    
    
    end