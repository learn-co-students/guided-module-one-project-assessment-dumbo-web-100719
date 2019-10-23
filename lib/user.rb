require 'tty-prompt'
class User < ActiveRecord::Base
    has_many :plans 
    has_many :places, through: :plans
    has_many :careers, through: :plans

    def view_plans
        self.plans.all.each do |plan|
            puts "Your plan is to move to #{plan.place.name} and work as a #{plan.career.name}!"
        end
    end

    def make_a_new_plan
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
        
        selection = prompt.select("Let's look at some places:", [
            { name: "Best Value", value: 1 },
            { name: "All Places", value: 2}
        ])
        if selection == 1
            Place.all.select do |place|
                if @new_plan.career.salary >= (place.median_income)*1.5
                    puts "#{place.name} - #{place.median_income}"
                end
            end
        elsif selection ==2
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
        @new_plan.save
        puts "Awesome! Your new life plan is to move to #{@new_plan.place.name} and work as a #{@new_plan.career.name} and make $#{@new_plan.career.salary} per year!"
        puts "Sounds like a great life!"
            

        
    end

    def prompt
        @prompt ||= TTY::Prompt.new
    end

end
