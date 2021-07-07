require_relative '../config/environment'
require 'pry'
require_rel '../lib'

class CommandLineInterface

    
    def greet 
        #system "clear"
        puts ('Welcome to Feelings.mp3').yellow
        
        puts "------------------------"
        puts "Thanks for joining us!!"
        sleep(30)
        system "clear"
        
        prompt = TTY::Prompt.new
        choices = {register: 1, continue_as_guest: 2}
        selection = prompt.select("Let's get started!", choices)
        if selection == 1
            User.register
        elsif selection == 2
            guest_menu
        end 
        feeling 
    end 

    def feeling
        puts "We offer a service that recommends a database based on your mood"
        prompt = TTY::Prompt.new
        feeling_choices = {hyped: 1, heartbroken: 2, chill: 3, skip: 4}
        feeling_selection = prompt.select("How are you feeling todaycle?", feeling_choices)
        
        if feeling_selection == 1
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you..."
            puts "---------------------------"
            Run.hyped
            
            song = Song.all.map do |song|
                if song.feeling == "hyped"
                    puts "#{song.name} by #{song.artist}"
                end 
            end 
        elsif feeling_selection == 2
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you..."
            puts "---------------------------"
            fork{exec'afplay', "./lib/music/off_heartbroken.mp3"}
            
            song = Song.all.map do |song|
                if song.feeling == "heartbroken"
                    puts "#{song.name} by #{song.artist}"
                end 
            end 
        elsif feeling_selection == 3
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you..."
            puts "---------------------------"
            fork{exec'afplay', "./lib/music/off_chill.mp3"}
            
            song = Song.all.map do |song|
                if song.feeling == "chill"
                    puts "#{song.name} by #{song.artist}"
                end 
            end 
        elsif feeling_selection == 4
            puts ""
            puts "Okay, standby for more options!"
            puts ""
            puts ""
            main_menu
        end 
        puts ""
        puts ""
        puts "We hope you enjoy this creation"
        main_menu
    end 

    def guest_menu
        system "clear"
        puts "We offer a service that reccommends a database based on your mood".red 
        puts "----------------------------------------------------------------------"
        prompt = TTY::Prompt.new
        feeling_choices = {hyped: 1, heartbroken: 2, chill: 3, exit: 4}
        feeling_selection = prompt.select("How are you feeling?", feeling_choices)
        puts "loading..."
        sleep (2)
        system "clear"
        if feeling_selection == 1
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you...".yellow
            puts "---------------------------"
            song = Song.all.map do |song|
                if song.feeling == "hyped"
                    puts "#{song.name} by #{song.artist}"
                end 
            end 
            puts ""
            puts ""
            puts "We hope you enjoy this creation!"
        elsif feeling_selection == 2
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you...".yellow
            puts "---------------------------"
            song = Song.all.map do |song|
                if song.feeling == "heartbroken"
                    puts "#{song.name} by #{song.artist}"
                end 
            end
            puts ""
            puts ""
            puts ""
            puts "We hope you enjoy this creation!" 
        elsif feeling_selection == 3
            puts "loading..."
            sleep (2)
            system "clear"
            puts "Here's what we got for you...".yellow
            puts "---------------------------"
            song = Song.all.map do |song|
                if song.feeling == "chill"
                    puts "#{song.name} by #{song.artist}"
                end 
            end
            puts ""
            puts ""
            puts ""
            puts "We hope you enjoy this creation!" 

        elsif feeling_selection == 4
            system "clear"

            puts "Thanks for dropping in... Goodbye!".blue
            sleep(3)
            exit
        end 
        sleep(10) 
        puts "Thanks for dropping in... Goodbye!".blue
            
        exit
    end


    def main_menu
        sleep (2)
        puts "----MAIN MENU----"
        prompt = TTY::Prompt.new
        menu_choices = {update_profile: 1, delete_song: 2, exit: 3}
        menu_selection = prompt.select("What do you want to do?", menu_choices)
        case menu_selection
        when 1
            update_profile
        when 2
            delete_song
        when 3
            exit
        end 
        main_menu
    end 

    def update_profile
        prompt = TTY::Prompt.new
        update_choices = {user_name: 1, age: 2, location: 3}
        update_selection = prompt.select("What would you like to update?", update_choices)
        case update_selection
        when 1
            User.update_user_name
        when 2
            User.update_age
        when 3
            User.update_location 
        end 
        main_menu
    end 

end 


def delete_song 
    song = Song.all.map do |song|
        puts "#{song.name} by #{song.artist}"
    end 
    prompt = TTY::Prompt.new
    song_name = prompt.ask("Please enter the song you would like to delete:")
    song_delete = Song.find_by(name: song_name)
    song_delete.destroy
    puts "#{song_name} has been removed from your database."
    puts "This is the updated database."
    Song.all.map do |song|
        puts "#{song.name} by #{song.artist}"
    end 
end 