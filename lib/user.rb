require 'tty-prompt'
class User < ActiveRecord::Base
    has_many :plans 
    has_many :places, through: :plans
    has_many :careers, through: :plans

    def view_plans
        self.plans.all.each do |plan|
            puts "Your plan is to move to #{plan.place.name} and work as a #{plan.career.name}!"
        end
        puts "Wow, those are some awesome plans!"
    end

    def pick_a_career
        @new_plan = self.plans.create
        # binding.pry
        selection = prompt.select("Select a career from this list:", [
            { name: "developer", value: 1 },
            { name: "teacher", value: 2 },
            { name: "nurse", value: 3 },
            { name: "doctor", value: 4 },
            { name: "pilot", value: 5 } 
        ])
        if selection == 1
            @new_plan.career = Career.all.find {|career| career.name == "Software Developer"}
        elsif selection == 2
            @new_plan.career = Career.all.find {|career| career.name == "Teacher"}
        elsif selection == 3
            @new_plan.career = Career.all.find {|career| career.name == "Nurse"}
        elsif selection == 4
            @new_plan.career = Career.all.find {|career| career.name == "Doctor"}
        elsif selection == 5
            @new_plan.career = Career.all.find {|career| career.name == "Pilot"}
        end
        puts "Cool, your new career is #{@new_plan.career.name} and your new salary is $#{@new_plan.career.salary} a year!"
    end

    # def pick_a_lifestyle
    #     selection = prompt.select("", [
    #         { name: "beach bum", value: 1 },
    #         { name: "Coastal Elite", value: 2 },
    #         { name: "Small city, big town", value: 3 },
    #         { name: "hipster", value: 4 }
    # ])
    # if selection == 1
    #     @new_plan.place.lifestyle 

    # end

    def pick_a_place
        selection = prompt.select("Let's look at some places:", [
            { name: "Best Value", value: 1 },
            { name: "Lifestyles", value: 2},
            { name: "All Places", value: 3}
            ])
            if selection == 1
                Place.all.select do |place|
                    if @new_plan.career.salary >= (place.median_income)*1.5
                        puts "#{place.name} would be in your budget!"
                    elsif @new_plan.career.salary <= place.median_income*1.5
                        puts "#{place.name} is too expensive for you. Try changing your career."
                    end
                end
            elsif selection == 2
                selection = prompt.select("", [
                    { name: "beach bum", value: 1 },
                    { name: "Coastal Elite", value: 2 },
                    { name: "Small city, big town", value: 3 },
                    { name: "hipster", value: 4 }
                ])
                if selection == 1
                    puts "These places would be perfect for a beach bum!"
                    Place.all.each do |place|
                        if place.lifestyle == "beach bum"
                            puts place.name
                        end
                    end
                elsif selection == 2
                    puts "Move to these places to join the Coastal Elite!"
                    Place.all.each do |place|
                        if place.lifestyle == "Coastal Elite"
                            puts place.name
                        end
                    end
                elsif selection == 3
                    puts "City amenties with a small town vibe? Count me in!"
                    Place.all.each do |place|
                        if place.lifestyle == "Small city, big town"
                            puts place.name
                        end
                    end
                elsif selection == 4
                    puts "Seattle is a bit too mainstream for me, but maybe you'll like it."
                    Place.all.each do |place|
                        if place.lifestyle == "hipster"
                            puts place.name
                        end
                    end
                end
            elsif selection == 3
                Place.all.map do |place|
                    puts "Welcome to #{place.name}! The median income is #{place.median_income}."
                end
            end
                
            selection = prompt.select("Alright, let's pick a place to live!", [
                { name: "Miami", value: 1 },
                { name: "Los Angeles", value: 2 },
                { name: "Boston", value: 3 },
                { name: "Seattle", value: 4 },
                { name: "Charlotte", value: 5 },
                { name: "Pittsburgh", value: 6 },
                { name: "Kansas City", value: 7 },
                { name: "Cincinnati", value: 8 },
                { name: "San Diego", value: 9 },
                { name: "San Antonio", value: 10 },
                { name: "Austin", value: 11 },
                { name: "Manhattan", value: 12 },
                { name: "Brooklyn", value: 13 },
                { name: "Denver", value: 14 }
            ])
            if selection == 1
                @new_plan.place = Place.all.find {|place| place.name == "Miami, Florida"}
            elsif selection == 2
                @new_plan.place = Place.all.find {|place| place.name == "Los Angeles, California"}
            elsif selection == 3
                @new_plan.place = Place.all.find {|place| place.name == "Boston, Massachusetts"}
            elsif selection == 4
                @new_plan.place = Place.all.find {|place| place.name == "Seattle, Washington"}
            elsif selection == 5
                @new_plan.place = Place.all.find {|place| place.name == "Charlotte, North Carolina"}
            elsif selection == 6
                @new_plan.place = Place.all.find {|place| place.name == "Pittsburgh, Pennsylvania"}
            elsif selection == 7
                @new_plan.place = Place.all.find {|place| place.name == "Kansas City, Missouri"}
            elsif selection == 8
                @new_plan.place = Place.all.find {|place| place.name == "Cincinnati, Ohio"}
            elsif selection == 9
                @new_plan.place = Place.all.find {|place| place.name == "San Diego, California"}
            elsif selection == 10
                @new_plan.place = Place.all.find {|place| place.name == "San Antonio, Texas"}
            elsif selection == 11
                @new_plan.place = Place.all.find {|place| place.name == "Austin, Texas"}
            elsif selection == 12
                @new_plan.place = Place.all.find {|place| place.name == "Manhattan, New York"}
            elsif selection == 13
                @new_plan.place = Place.all.find {|place| place.name == "Brooklyn, New York"}
            elsif selection == 14
                @new_plan.place = Place.all.find {|place| place.name == "Denver, Colorado"}
            end
    end

    def make_a_new_plan
        @new_plan.save
        # binding.pry
        puts "Awesome! Your new life plan is to move to #{@new_plan.place.name} and work as a #{@new_plan.career.name} and make $#{@new_plan.career.salary} per year!"
        puts "Sounds like a great life!" 
    end

    def update_plan
        # binding.pry
        array_of_plans = self.plans.map {|plan| {name: "#{plan.career.name} in #{plan.place.name}", value: plan.id}}
        selection = prompt.select("Please pick a plan to change:", array_of_plans.push({name: 'Nevermind', value: -1}))
        if selection != -1
            self.plans.each do |plan|
                if plan.id == selection
                    selection = prompt.select("Please pick a new career:", [
                        { name: "developer", value: 1 },
                        { name: "teacher", value: 2 },
                        { name: "nurse", value: 3 },
                        { name: "doctor", value: 4 },
                        { name: "pilot", value: 5 } 
                    ])
                if selection == 1
                    plan.career = Career.all.find {|career| career.name == "Software Developer"}
                elsif selection == 2
                    plan.career = Career.all.find {|career| career.name == "Teacher"}
                elsif selection == 3
                    plan.career = Career.all.find {|career| career.name == "Nurse"}
                elsif selection == 4
                    plan.career = Career.all.find {|career| career.name == "Doctor"}
                elsif selection == 5
                    plan.career = Career.all.find {|career| career.name == "Pilot"}
                end
                puts "Cool, your new career is #{plan.career.name} and your new salary is $#{plan.career.salary} a year!"
                plan.save
                end
            end
        else
            puts "Okay, I'll keep all of your plans just the way they are!"
                
        end
         
    end


    # def update_plan
    #     array_of_plans = self.plans.map {|plan| {name: plan.place.name, value: plan.id}}
    #     selection = prompt.select("Please pick a plan to change:", array_of_plans)
    #     binding.pry
    #     if selection == 
    #     # binding.pry
    # #   array=self.plans.map |plan| {name: plan.name, value: plan.id}
    #     # puts "I'm sorry you aren't happy with all of your plans!"
    #     # selection = prompt.select("Please pick a plan to change:", [
    #     #    array_of_plans
    #     # ])
    #     # binding.pry
    #     # if selection == array_of_plans
        
    #     # binding.pry


    #     # if selection == 1
    #     #     puts "Please tell me which career you want to change"
    #     #     change_this_career = gets.chomp
    #     #     # binding.pry
    #     #     career_names = self.plans.all.map {|plan| plan.career.name}
    #     #     career_names.find do |name|
    #     #         if name == change_this_career
    #     #         end
    #     #     end
    #     #     self.plans.all
    #     #         # if plan.career == change_this_career
    #     #         #     plan.career = change_this_career
    #     #         #     binding.pry
    #     #         # end
    #     # elsif selection == 2
    #     #     puts "cool2"
    #     # elsif selection == 3
    #     #     puts "Okay! I'm glad you're happy with your life!"
    #     # end

    #     # binding.pry
    # end

    def delete_plan
        array_of_plans = self.plans.map {|plan| {name: "#{plan.career.name} in #{plan.place.name}", value: plan.id}}
        selection = prompt.select("Please pick a plan to delete:", array_of_plans.push({name: 'Nevermind', value: -1}))
        if selection != -1
            self.plans.find do |plan|
                if plan.id == selection
                    plan.delete
                end
            end
            puts "Your plan is gone. I'm glad. It was a terrible plan." 
        else
            puts "Okay, I won't delete any of your plans."
        end

    end

    # def delete_plan
    #     self.plans.all.each do |plan|
    #         puts "Your plan is to move to #{plan.place.name} and work as a #{plan.career.name}!"
    #     end
    #     puts "These are your current plans. I'm going to delete your most recent plan!"
    #     selection = prompt.select("Is that okay with you?", [
    #             {name: "Yes! I hated that plan!", value: 1},
    #             {name: "No, wait, I loved that plan!", value: 2}
    #     ])
    #     if selection == 1   
    #         self.plans.all.last.delete
    #         puts "Your plan is gone. I'm glad. It was a terrible plan."
    #     elsif selection == 2
    #         puts "Okay, I won't delete anything!"
    #     end
    # end

    def prompt
        @prompt ||= TTY::Prompt.new
    end

end
