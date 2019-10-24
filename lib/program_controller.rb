class CommandLineInterface

    attr_accessor :current_user
    # afplay ~lib/biking.mp3 &

    def greet   
        puts "Welcome to SwapCycle"
    end

    

    def render_ascii_art
        return_string = ""
        File.foreach("lib/banner.txt") do |line|
            return_string += line
        end
        puts return_string
    end

    def prompt
        @prompt = TTY::Prompt.new
    end

    def update_profile
        prompt.select "What Do You Want To Update" do |menu|
            menu.choice "Update Name", ->{update_name}
            menu.choice "Update Phone Number", ->{update_number}
            menu.choice "Update Email", ->{update_email}
            menu.choice "Update What You Are Looking For", ->{update_lf}
            menu.choice "Go Back", -> {user_profile} 
        end
    end

    def update_name
        new_name = prompt.ask("New Name")
        @current_user.update(name: new_name)
        puts "Your Name Has Been Updated"
        sleep(2)
        update_profile
    end

    def update_number
        new_number = prompt.ask("New Number")
        @current_user.update(phone_number: new_number)
        puts "Your Phone Number Has Been Updated"
        sleep(2)
        update_profile
    end

    def update_email
        new_email = prompt.ask("New Email")
        @current_user.update(email: new_nemail)
        puts "Your Email Has Been Updated"
        sleep(2)
        update_profile
    end

    def update_lf
        new_lf = prompt.ask("What Are You Looking For Now?")
        @current_user.update(looking_for: new_lf)
        puts "What You're Looking For Has Been Updated"
        sleep(2)
        update_profile
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
            menu.choice "View Your Profile", -> {user_profile}
            menu.choice "Add Your Bike to Swap", -> {add_new_bike}
            menu.choice "Remove Bike", -> {remove_bike}
            menu.choice "Request A Bike", -> {see_available_bikes}
            # menu.choice "Swap Requests", -> {see_all_requests}
            # menu.choice "Swaps Completed", -> {completed_swaps,} 
            menu.choice "Sign Out", -> {login_prompt}
        end
    end

    def user_profile
        your_profile = User.find(@current_user.id)
        
        # binding.pry
        # see_user = your_profile.map{|user| "#{user.name}, #{user.phone_number}, #{user.email}, #{user.looking_for}"}
        
        puts "Profile Name:  #{your_profile.name}"
        puts "Email:  #{your_profile.email}"
        puts "Phone Number:  #{your_profile.phone_number}"
        puts "Looking For:  #{your_profile.looking_for}"
        puts "Bikes: #{your_profile.bikes.map{|bike| bike.type_of_bike}.split(",")}"
        prompt.select "Options" do |menu|
            menu.choice "Update Profile", -> {update_profile}
            menu.choice "Go Back", -> {main_menu}
        end

    end

    def add_new_bike
        logged_in_user = User.find(@current_user.id)
        user_location = prompt.ask("Where Are You Located")
        bike_type = prompt.ask("Type of Bicycle")
        bike_brand = prompt.ask("Brand of Bicycle")
        bike_size = prompt.ask("Bicycle Size")
        bike_condition = prompt.ask("Condition of Bicycle")
        @bike = Bike.create(user_id: logged_in_user.id, location: user_location, type_of_bike: bike_type, brand: bike_brand, size_of_bike: bike_size, condition: bike_condition, available: true)
        main_menu
        sleep(5)
        go_back_prompt = prompt.yes?("Yo, Do You Want To Go Back?")
        if go_back_prompt != "n"
            main_menu
        else add_new_bike
        end
    end

    def remove_bike
        logged_in_user = User.find(@current_user.id)
        if logged_in_user.bikes.length == 0
            puts "You Dont Have Any Bikes Bruh"
            sleep(2)
            main_menu
        end

        users_bikes = logged_in_user.bikes.map {|bike| "#{bike.id}.#{bike.type_of_bike} - #{bike.location} "}
        users_bikes.push "Back" 
        bikes = prompt.select "Which Bike Do You Want To Remove", users_bikes
            if bikes == "Back"
                main_menu
            end
        remove_prompt = prompt.yes?("Dude, Are You Sure?")
            if remove_prompt != "n"
               destroy_bike = logged_in_user.bikes.find{|bike| bike.id == bikes[0..2].to_i}
            #    binding.pry
               destroy_bike.destroy
               
            #    binding.pry
                puts "Bike Removed!"
                main_menu
            else bikes 
            end

        sleep(5)
            go_back_prompt = prompt.yes?("Yo, Do You Want To Go Back?")
                if go_back_prompt != "n"
                    main_menu
                else remove_bike
                end
    end



    ################################################

    #See all bikes where available is = true that aren't yours
    #Send a request for that bike based on its ID
    #request appears in your pending sent
    #request appears in Bike Owners pending received

    def see_available_bikes #menu
    #    binding.pry
        all_bikes = Bike.all.map{|bike| bike}
        all_your_bikes = @current_user.bikes.map{|bike| "#{bike.id}. #{bike.type_of_bike} - #{bike.location}"}
       
        bikes = all_bikes.select{|bike| bike.user_id != @current_user.id && bike.available == true}
        bike_details = bikes.map {|bike| "#{bike.id}. #{bike.type_of_bike} - #{bike.location} "}
        bike_details.push "Go Back"
        bike_choice = prompt.select "<See All Bikes Available to Swap>", bike_details
            if bike_choice == "Go Back"
                main_menu
            end
        # binding.pry
        new_request = prompt.yes?("Do You Want To Request This Bike")
            if new_request == "no"
                see_available_bikes
            else
                #if they hit yes, saves that choice to a variable
                #create promot that asks you to selct your bike.
                #that gets saved into a vvariable and passed into a new request
                #both bikes availability turns into false
                #exits to main menu
            your_bike = prompt.select "Which Of Your Bikes Do You Want To Swap", all_your_bikes
                Request.create(requester_bike_id: your_bike[0..2].to_i, requestee_bike_id: bike_choice[0..2].to_i) 
                # bike_choice.available = false
                # your_bike.available = false
                puts "You Have Sent A Request! Good Luck!"
                sleep(2)
                main_menu                              
            end
        # @current_user.requests << Request.create(requesters: @current_user, :requestees @bikes.user_id) 
        # puts "You Sent A Request! Hope It Works Out!"
        # sleep(3)
    end

    

    #################################################
    
    def see_all_requests #menu
        prompt.select"<Request Menu>" do |menu|
            menu.choice "See All Requests You've Sent", -> {requests_sent_pending}
            menu.choice "See All Pending Requests Received", -> {requests_received_pending}
            menu.choice "Go Back", -> {main_menu}
        end
    end

    def requests_sent_pending
       
        pending_requests = Request.all.select{|request| request.requester_bike_id == @current_user.id}
        binding.pry 
    end

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