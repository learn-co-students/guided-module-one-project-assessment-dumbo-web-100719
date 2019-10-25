class User < ActiveRecord::Base
    has_many :songs, through: :playlists 

     def self.register
        system "clear"
        prompt = TTY::Prompt.new
        email = prompt.ask("Email:")
        user_name = prompt.ask("Username:")
        age = prompt.ask("How old are you?")
        location = prompt.ask("Where are you located?")
        password = prompt.mask("Password:")
        @user = User.create(name: user_name, age: age, location: location)
        puts "Thanks for joining us #{user_name}".green
    end 

    def self.update_user_name
        system "clear"
        prompt = TTY::Prompt.new
        new_user_name = prompt.ask("New Username:")
        @user.update(name: new_user_name)
        puts "#{new_user_name}, your profile name has been updated.".green

    end 

    def self.update_age
        system "clear"
        prompt = TTY::Prompt.new
        new_age = prompt.ask("New Age:")
        @user.update(age: new_age)
        filler = "Your age has been updated to #{new_age} years old."
        puts filler. green
        puts "_"* filler.length 
       
    end 

    def self.update_location
        system "clear"
        prompt = TTY::Prompt.new
        new_location = prompt.ask("New Location:")
        @user.update(location: new_location)
        puts "Congratulations on moving to #{new_location}!"
    end 

end 