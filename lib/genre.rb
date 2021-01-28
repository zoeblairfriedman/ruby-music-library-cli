class Genre
    attr_accessor :name
    extend Findable::ClassMethods

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
        new_addition = Genre.new(name)
        self.all << new_addition
        new_addition
    end

    def songs
        @songs
    end

    def artists
        self.songs.collect{|song| song.artist}.uniq
    end
    
    end