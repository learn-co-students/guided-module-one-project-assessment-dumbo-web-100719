User.destroy_all
Place.destroy_all
Career.destroy_all
Plan.destroy_all

#users
@javone = User.create(name: "javone", username: "javone_smith", password: "javone1")
@hope = User.create(name: "hope", username: "hope_giometti", password: "hopeisthebest")

#places
@miami = Place.create(name: "Miami, Florida", median_income: 54_000, lifestyle: "beach bum")
@la= Place.create(name: "Los Angeles, California", median_income: 56_000, lifestyle: "beach bum")
@boston = Place.create(name: "Boston, Massachusetts", median_income: 64_000, lifestyle: "Coastal Elite")
@seattle = Place.create(name: "Seattle, Washington", median_income: 93_500, lifestyle: "hipster")
@charlotte = Place.create(name: "Charlotte, North Carolina", median_income: 53_000, lifestyle: "Small city, big town")
@pittsburgh = Place.create(name: "Pittsburgh, Pennsylvania", median_income: 59_000, lifestyle: "Small city, big town")
@kansas_city = Place.create(name: "Kansas City, Missouri", median_income: 45_000, lifestyle: "Small city, big town")
@cincinnati = Place.create(name: "Cincinnati, Ohio", median_income: 62_000, lifestyle: "Small city, big town")
@san_diego = Place.create(name: "San Diego, California", median_income: 77_000, lifestyle: "beach bum")
@san_antonio = Place.create(name: "San Antonio, Texas", median_income: 57_000, lifestyle: "Small city, big town" )
@austin = Place.create(name: "Austin, Texas", median_income: 55_000, lifestyle: "hipster")
@manhattan = Place.create(name: "Manhattan, New York", median_income: 67_000, lifestyle: "Coastal Elite")
@brooklyn = Place.create(name: "Brooklyn, New York", median_income: 45_000, lifestyle: "hipster")
@denver = Place.create(name: "Denver, Colorado", median_income: 65_000, lifestyle: "hipster")


#careers
@developer = Career.create(name: "Software Developer", salary: 83_000)
@teacher = Career.create(name: "Teacher", salary: 39_000)
@nurse = Career.create(name: "Nurse", salary: 73_500)
@doctor = Career.create(name: "Doctor", salary: 294_000)
@pilot = Career.create(name: "Pilot", salary: 130_000)

#plans
@hope_plan_1 = Plan.create(user: @hope, place: @miami, career: @developer)
@hope_plan_2 = Plan.create(user: @hope, place: @la, career: @teacher)

#lifestyles
# @beach_bum = Lifestyle.create(name: "beach bum")
# @coastal_elite = Lifestyle.create(name: "Coastal Elite")
# @rich_hippy = Lifestyle.create(name: "Rich Hippie aka Californian")
# @crunchy_granola = Lifestyle.create(name: "Crunchy Granola")
