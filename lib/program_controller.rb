class CommandLineInterface

    def greet
        render_ascii_art
        puts "Welcome to SwapCycle"
    end

    def render_ascii_art
        File.readlines("biker.txt") do |line|
          puts line
        end
    end

    def prompt
        @prompt = TTY::Prompt.new
    end

    def login_prompt
        prompt.select "<Are You An Existing Swapper?> " do |menu|
            menu.choice "Yes", -> {login}       
            menu.choice "No" , -> {new_user}
            menu.choice "Exit", -> {exit}
        end
    end

    def login
        name = prompt.ask("Please Enter Your Name")
        User.find_by(name: name)
        main_menu  
    end

    def new_user
        user_name = prompt.ask("Please Enter Your Name")
        user_phone_number = prompt.ask("Please Enter Your Phone Number Ex: 555-555-5555")
        user_email = prompt.ask("Please Enter Your Email")
        user_looking_for = prompt.ask("What Kind Of Bike Are You Looking For?")
        @user = User.create(name: user_name, phone_number: user_phone_number, email: user_email, looking_for: user_looking_for)
        puts "User Profile Created!"
        main_menu
    end

    def main_menu
        prompt.select"<Main Menu>" do |menu|
            menu.choice "Add Your Bike to Swap", -> {add_new_bike}
            menu.choice "Remove Bike", -> {remove_bike}
            menu.choice "See All Bikes Available to Swap", -> {see_available_bikes}
            menu.choice "Swap Requests", -> {see_all_requests}
            menu.choice "Swaps Completed", -> {completed_swaps}
            menu.choice "Sign Out", -> {login_prompt}
        end
    end

    def add_new_bike

    end

    # def remove_bike

    # end

    ################################################

    #See all bikes where available is = true that aren't yours
    #Send a request for that bike based on its ID
    #request appears in your pending sent
    #request appears in Bike Owners pending received

    # def see_available_bikes #menu

    # end

    

    #################################################
    
    # def see_all_requests #menu

    # end

    # def requests_sent_pending

    # end

    ##################################################

    #See all pending requests for your bikes, choose which request you want to accept,
    #that bike gets added to your swap completed and yours gets added to theirs
    #Go Back to main menu

    # def requests_received_pending 

    # end
    
    ##################################################
    #Show all completed swaps
    #add that bike to bikes you want to swap
    # Go back to Main Menu
    
    # def completed_swaps

    # end

    # def exit
    #     exit
    # end

end