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
        all_careers = Career.all.map {|career| {name: career.name, value: career.id}}
        selection = prompt.select("Select a career from this list:", all_careers)
        Career.all.each do |career|
            if career.id == selection
                @new_plan.career = career
            end
        end
        puts "Cool, your new career is #{@new_plan.career.name} and your new salary is $#{@new_plan.career.salary} a year!"
    end

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
                    puts "#{place.name} has a median income of #{place.median_income}."
                end
            end

            all_places = Place.all.map {|place| {name: place.name, value: place.id}}
            selection = prompt.select("Alight, let's pick a place to live!", all_places)
            Place.all.each do |place|
                if selection == place.id
                    @new_plan.place = place
                end
            end
    end

    def make_a_new_plan
        @new_plan.save
        puts "Awesome! Your new life plan is to move to #{@new_plan.place.name} and work as a #{@new_plan.career.name} and make $#{@new_plan.career.salary} per year!"
        puts "Sounds like a great life!" 
    end

    def update_plan
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
                    plan.career = Career.all.detect {|career| career.name == "Software Developer"}
                elsif selection == 2
                    plan.career = Career.all.detect {|career| career.name == "Teacher"}
                elsif selection == 3
                    plan.career = Career.all.detect {|career| career.name == "Nurse"}
                elsif selection == 4
                    plan.career = Career.all.detect {|career| career.name == "Doctor"}
                elsif selection == 5
                    plan.career = Career.all.detect {|career| career.name == "Pilot"}
                end
                puts "Cool, your new career is #{plan.career.name} and your new salary is $#{plan.career.salary} a year!"
                plan.save
                end
            end
        else
            puts "Okay, I'll keep all of your plans just the way they are!"
                
        end
         
    end

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

    def prompt
        @prompt ||= TTY::Prompt.new
    end

end
