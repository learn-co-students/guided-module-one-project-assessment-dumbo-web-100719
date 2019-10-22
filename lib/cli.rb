require 'pry'
class CommandLineInterface

    def greet
        puts "Let's plan your life!"
    end

    def login
        puts "Have you planned your life before?"
        selection = prompt.select("Please login or sign up:", [
            { name: "Login", value: 1 },
            { name: "Sign Up", value: 2},
            { name: "Exit", value: 3}
        ])
        if selection == 1
            login
        elsif selection == 2
            sign_up
        elsif selection == 3
            puts "Okay, goodbye!"
            return
        end
    end

    def self.pick_a_career
        selection = prompt.select("Select a career from this list:", [
            { name: "developer", value: 1 },
            { name: "teacher", value: 2 },
            { name: "nurse", value: 3 },
            { name: "doctor", value: 4 },
            { name: "pilot", value: 5 }
        ])
        if selection == 1
            Plan.create(career: @developer)
        elsif selection == 2
            Plan.create(career: @teacher)
        elsif selection == 3
            Plan.create(career: @nurse)
        elsif selection == 4
            Plan.create(career: @doctor)
        elsif selection == 5
            Plan.create(career: @pilot)
        end
        
    end

    def exisiting_account_login
        puts "Please enter your username:"
        user_username = gets.chomp
        password = TTY::Prompt.new
        user_password = password.mask("Please enter your password:")
        user = User.find_by(username: user_username, password: user_password)
        if user == nil
            puts "No user found. Please try again."
            exisiting_account_login
        else
            puts "Hello #{user.name}. Welcome back!"
        end
        user
    end

    def create_new_user_account
        puts "What would you like your username to be?"
        user_username_input = gets.chomp
        user = User.find_by(username: user_username_input)
        if user == nil
           puts "Nice! What's your name?"
           user_name = gets.chomp
           password = TTY::Prompt.new
           user_password = password.mask("Got it. Choose a password: ")
           puts "You are all set up, #{user_name}! Your username is #{user_username_input}."
           user = User.create(name: user_name, username: user_username_input, password: user_password)
        else
            puts "Sorry that username is already taken."
            create_new_user_account
        end
        user
    end

    def what_do
        selection = prompt.select("What do you want to do?", [
            { name: "Make a new plan", value: 1},
            { name: "Update plan", value: 2},
            { name: "View all plans", value: 3},
            { name: "Exit", value: 4}
        ])
        if selection == 1
            make_new_plan
        elsif selection == 2
            update_plan
        elsif selection == 3
            view_plans
        elsif selection == 4
            puts "Okay, goodbye!"
        end
    end

    def make_new_plan
        selection = prompt.select("Select a career from this list:", [
            { name: "developer", value: 1 },
            { name: "teacher", value: 2 },
            { name: "nurse", value: 3 },
            { name: "doctor", value: 4 },
            { name: "pilot", value: 5 }
        ])
        if selection == 1
            Plan.create(career: @developer)
        elsif selection == 2
            Plan.create(career: @teacher)
        elsif selection == 3
            Plan.create(career: @nurse)
        elsif selection == 4
            Plan.create(career: @doctor)
        elsif selection == 5
            Plan.create(career: @pilot)
        end

        selection2 = prompt.select("Take a look at some places!", [
            {name: "All Places", value: 1},
            {name: "Exit", value: 2}
        ])
        if selection == 1
            all_place_names = Place.all.map { |place| place.name }
            puts all_place_names
        elsif selection == 2
            puts "Okay, goodbye."
        end
    
    end

    def prompt
        @prompt ||= TTY::Prompt.new
    end



end