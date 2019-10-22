class CommandLineInterface

    def greet
        puts "Welcome to SwapCycle"
    end

    def prompt
        @prompt = TTY::Prompt.new
    end

    # def login_prompt
    #     prompt.select "Are You An Existing Swapper?" do |menu|
    #         menu.choice "Yes" do
    #         name = prompt.ask("Please Enter Your Name")
    #         @user = User.find_by(name: name)
    #         end
    #         menu.choice "No ("Create New Swapper")" -> {new_user}
    #         menu.choice "Exit("Exit")" -> {exit}
    #     end
    # end

   

    # def new_user
    #     user_name = prompt.ask("Please Enter Your Name")
    #     user_phone_number = prompt.ask("Please Enter Your Phone Number Ex: 555-555-5555")
    #     user_email = prompt.ask("Please Enter Your Email")
    #     user_looking_for = prompt.ask("What Kind Of Bike Are You Looking For?")
    #     @user = User.create(name: user_name, phne_number: user_phone_number, email: user_email, looking_for: user_looking_for)
    #     main_menu
    # end

    # def main_menu

    # end

    # def add_new_bike

    # end

    # def remove_bike

    # end

    # def see_available_bikes #menu

    # end

    # def see_all_requests #menu

    # end

    # def requests_sent_pending

    # end

    # def requests_received_pending

    # end

    # def completed_swaps

    # end

    # def exit
    #     exit
    # end

end