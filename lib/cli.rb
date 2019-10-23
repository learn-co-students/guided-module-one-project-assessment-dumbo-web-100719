require 'pry'
require 'tty-prompt'
require_all 'lib'

class CommandLineInterface

    def greet
        puts "Let's plan your life!"
    end

    def exisiting_account_login
        puts "Please enter your username:"
        user_username = gets.chomp
        password = TTY::Prompt.new
        user_password = password.mask("Please enter your password:")
        @user = User.find_by(username: user_username, password: user_password)
        if @user == nil
            puts "No user found. Please try again."
            exisiting_account_login
        else
            puts "Hello #{@user.name}. Welcome back!"
        end
        @user
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
            @user.make_a_new_plan
            what_do
        elsif selection == 2
            update_plan
            what_do
        elsif selection == 3
            @user.view_plans
            what_do
        elsif selection == 4
            puts "Okay, goodbye!"
        end
    end

    def make_new_plan
        new_plan = Plan.create()
        new_plan.pick_a_career
    end

    def prompt
        @prompt ||= TTY::Prompt.new
    end



end