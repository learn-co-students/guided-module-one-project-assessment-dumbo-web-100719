User.destroy_all
Place.destroy_all

#users
@javone = User.create(name: "javone")
@hope = User.create(name: "hope")

#places
@miami = Place.create(name: "Miami, Florida", median_income: 54_000)
@la= Place.create(name: "Los Angeles, California", median_income: 56_000)
@boston = Place.create(name: "Boston, Massachusetts", median_income: 64_000)

#careers
@developer = Career.create(name: "Software Developer", salary: 83_000)
@teacher = Career.create(name: "Teacher", salary: 39_000)
