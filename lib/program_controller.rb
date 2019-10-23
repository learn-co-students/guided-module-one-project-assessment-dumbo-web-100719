class CommandLineInterface

    attr_accessor :current_user

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
        found_user = User.find_by(name: name)
        
        while !found_user
            name = prompt.ask("User Not Found Try Again")
            found_user = User.find_by(name: name)
        end 
        @current_user = found_user
        main_menu  
    end

    def new_user
        user_name = prompt.ask("Please Enter Your Name")
        user_phone_number = prompt.ask("Please Enter Your Phone Number Ex: 555-555-5555")
        user_email = prompt.ask("Please Enter Your Email")
        user_looking_for = prompt.ask("What Kind Of Bike Are You Looking For?")
        @current_user = User.create(name: user_name, phone_number: user_phone_number, email: user_email, looking_for: user_looking_for)
        puts "User Profile Created!"
        main_menu
    end

    def main_menu
        prompt.select"<Main Menu>" do |menu|
            menu.choice "Add Your Bike to Swap", -> {add_new_bike}
            menu.choice "Remove Bike", -> {remove_bike}
            menu.choice "Request A Bike", -> {see_available_bikes}
            menu.choice "Swap Requests", -> {see_all_requests}
            menu.choice "Swaps Completed", -> {completed_swaps}
            menu.choice "Sign Out", -> {login_prompt}
        end
    end

    def add_new_bike
        user_location = prompt.ask("Where Are You Located")
        bike_type = prompt.ask("Type of Bicycle")
        bike_brand = prompt.ask("Brand of Bicycle")
        bike_size = prompt.ask("Bicycle Size")
        bike_condition = prompt.ask("Condition of Bicycle")
        @bike = Bike.create(user_id: @current_user.id, location: user_location, type_of_bike: bike_type, brand: bike_brand, size_of_bike: bike_size, condition: bike_condition, available: true)
        main_menu
    end

    # def remove_bike

    # end

    ################################################

    #See all bikes where available is = true that aren't yours
    #Send a request for that bike based on its ID
    #request appears in your pending sent
    #request appears in Bike Owners pending received

    def see_available_bikes #menu
    #    binding.pry
        bikes = Bike.all.select{|bike| bike.user_id != @current_user.id }.split
        bike_choice = prompt.select "<See All Bikes Available to Swap>", bikes
        bike = Bike.find_by(type_of_bike: bike_choice)
        new_request = prompt.yes?("Do You Want To Request This Bike")
            if new_request != "Y"
                see_available_bikes
            else current_user.requesters << Request.create(requester_id: current_user.id, requestee_id: bike.user_id)
                see_available_bikes
            end
        # @current_user.requests << Request.create(requesters: @current_user, :requestees @bikes.user_id) 
        # puts "You Sent A Request! Hope It Works Out!"
        # sleep(3)
        main_menu  
    end

    

    #################################################
    
    def see_all_requests #menu
        prompt.select"<Request Menu>" do |menu|
            menu.choice "See All Requests You've Sent", -> {requests_sent_pending}
            menu.choice "See All Pending Requests Received", -> {requests_received_pending}
        end
    end

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