require 'pry'
require_relative '../config/environment'

class MusicLibraryController
attr_accessor :path

def initialize(path="./db/mp3s")
   # binding.pry
   @path = path
   MusicImporter.new(path).import
end

def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'." 
    puts "What would you like to do?"
    input = gets.chomp

    if input == 'list songs'
        list_songs
    elsif input == 'list artists'
        list_artists
    elsif input == 'list genres'
        list_genres
    elsif input == 'list artist'
        list_songs_by_artist
    elsif input == 'list genre'
        list_songs_by_genre
    elsif input == 'play song'
        play_song
    elsif input == 'exit'
        ## exit?
    else
        call
    end
end

def list_songs
    sorted_songs = Song.all.sort_by { |song| song.name }
    sorted_songs.each_with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
end

def list_artists
    sorted_artists = Artist.all.sort_by { |artist| artist.name }
    sorted_artists.each_with_index do |artist, i|
        puts "#{i+1}. #{artist.name}"
    end
end

def list_genres
    sorted_genres = Genre.all.sort_by { |genre| genre.name }
    sorted_genres.each_with_index do |genre, i|
        puts "#{i+1}. #{genre.name}"
    end
end

def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
        if Artist.find_by_name(input)
        artist = Artist.find_by_name(input)
        artist_list = artist.songs.sort_by { |song| song.name }
        artist_list.each_with_index do |song, i|
            puts "#{i+1}. #{song.name} - #{song.genre.name}"
        end
    end
end

def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
        if Genre.find_by_name(input)
        genre = Genre.find_by_name(input)
        genre_list = genre.songs.sort_by { |song| song.name }
        genre_list.each_with_index do |song, i|
            puts "#{i+1}. #{song.artist.name} - #{song.name}"
        end
    end
end

def play_song
    puts "Which song number would you like to play?"
    selection = gets.chomp.to_i
    sorted_songs = Song.all.sort_by { |song| song.name }
    if selection > 0 && selection < sorted_songs.length + 1
        choice = sorted_songs[selection - 1]
        puts "Playing #{choice.name} by #{choice.artist.name}"
    end
end

end