# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
  "Cat",
  "Dog",
  "Horse",
  "Barnyard",
  "Pig",
  "Rabbit",
  "Small & Furry",
  "Scales, Fins & Other",
  "Wildlife",
].each do |animal_type|
  AnimalType.find_or_create_by!(name: animal_type)
end

[
  "Angels Camp",
  "Avery",
  "Clearlake",
  "Clearlake Oaks",
  "Cobb",
  "Finley",
  "Glenhaven",
  "Harbin Springs",
  "Hidden Valley Lake",
  "Jackson",
  "Kelseyville",
  "Lakeport (city not county)",
  "Loch Lomond",
  "Lower Lake",
  "Lucerne",
  "Middletown",
  "Nice",
  "Park",
  "San Andreas",
  "Upper Lake",
  "Whispering Pines",
  "Witter Springs",
  "Other (please specify in description)",
].each do |location|
  Location.find_or_create_by!(name: location)
end
