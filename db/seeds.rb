User.destroy_all
Place.destroy_all

#users
@javone = User.create(name: "javone")
@hope = User.create(name: "hope")

#places
@miami = Place.create(name: "Miami, Florida", median_income: 54_000)
@la= Place.create(name: "Los Angeles, California", median_income: 56_000)
@boston = Place.create(name: "Boston, Massachusetts", median_income: 64_000)
@seattle = Place.create(name: "Seattle, Washington", median_income: 93_500)
@charlotte = Place.create(name: "Charlotte, North Carolina", median_income: 53_000)
@pittsburg = Place.create(name: "Pittsburg, Pennsylvania", median_income: 59_000)
@kansas_city = Place.create(name: "Kansas City, Missouri", median_income: 45_000)
@cincinnati = Place.create(name: "Cincinnati, Ohio", median_income: 62_000)
@san_diego = Place.create(name: "San Diego, California", median_income: 77_000)
@san_antonio = Place.create(name: "San Antonio, Texas", median_income: 57_000)
@austin = Place.create(name: "Austin, Texas", median_income: 55_000)
@manhattan = Place.create(name: "Manhattan, New York", median_income: 67_000)
@brooklyn = Place.create(name: "Brooklyn, New York", median_income: 45_000)
@denver = Place.create(name: "Denver, Colorado", median_income: 65_000)


#careers
@developer = Career.create(name: "Software Developer", salary: 83_000)
@teacher = Career.create(name: "Teacher", salary: 39_000)
@nurse = Career.create(name: "Nurse", salary: 73_500)
@doctor = Career.create(name: "Doctor", salary: 294_000)
@pilot = Career.create(name: "Pilot", salary: 130_000)
