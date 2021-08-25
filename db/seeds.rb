# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Flight.destroy_all

puts "creating default user"
User.create(email: "michel@gmail.com", password: "lewagon")

Flight.create(
  departure: 'Paris-Charles de Gaulle',
  compagnie_name: "Air France",
  departure_date: Date.parse("2021-08-28"),
  duration: 700,
  arrival: "Aéroport international de San Francisco",
  arrival_date: Date.parse("2021-08-28"),
  airport_iata_code: "SFO",
  price: 2474.to_f,
  departure_flight: true
)

Flight.create(
  departure: 'Aéroport international de San Francisco',
  compagnie_name: "Air France",
  departure_date: Date.parse("2021-09-01"),
  duration: 600,
  arrival: "Paris-Charles de Gaulle",
  arrival_date: Date.parse("2021-09-01"),
  airport_iata_code: "CDG",
  price: 2479.to_f,
)

ACTIVITIES = [{
  name: "Yosemite",
  address: "California, États-Unis",
  longitude: -119.538329,
  latitude: 37.865101,
  category: 'national park',
  description: "Yosemite is an American national park, located in the Sierra Nevada Mountains in the eastern state of California.",
  duration: 900,
  price: 00.to_f
  },

  {
  name: "Los Angeles",
  address: "California, États-Unis",
  longitude: -118.243685,
  latitude: 34.052234,
  category: 'city',
  description: 'With more than 18.5 million people in its metropolitan area and 1,302 square kilometers of land, it is the second largest city in the United States.',
  duration: 1500,
  price: 00.to_f
  },
  {
  name: "Death Valley",
  address: "California, États-Unis",
  longitude: -116.881828,
  latitude: 36.513879,
  category: 'national park',
  description: "Death Valley is a valley in the Mojave Desert located in California and included in Death Valley National Park. It is an elongated, north-south trending endoretic rift.",
  duration: 360,
  price: 00.to_f
  },
  {
  name: "Las Vegas",
  address: "California, États-Unis",
  longitude: -115.139830,
  latitude: 36.169941,
  category: 'city',
  description: "Located in a valley on the borders of California, Arizona and Utah, Las Vegas is surrounded by snow-capped mountains in winter.",
  duration: 1500,
  price: 00.to_f
  },
  {
  name: "Monument Valley",
  address: "Arizona, Utah, États-Unis",
  longitude: -110.173479,
  latitude: 37.004245,
  category: 'tribal park',
  description: "Monument Valley is an American natural site located on the border between Arizona and Utah, near the Four Corners. It is remarkable by its geomorphological formations composed in particular of mesas and buttes.",
  duration: 360,
  price: 00.to_f
  }
 ]

ACTIVITIES.each do |activity|
  Activity.create!(activity)
 end



Hotel.create(
  name: "St. Regis San Francisco",
  address: "125 Third Street, San Francisco, CA 94103, États-Unis",
  stars: 5,
  description: "Located in San Francisco's SoMa neighborhood, The St. Regis San Francisco features a full-service spa, an infinity pool and an on-site restaurant. This luxury hotel has rooms with flat-screen TVs. Union Square is an 8-minute walk away.",
  price: 525.to_f,
  longitude: -122.401322,
  latitude: 37.786314
 )

Hotel.create(
  name: "The Palazzo at The Venetian",
  address: "3325 Las Vegas Boulevard South, Strip, Las Vegas, NV 89109, États-Unis",
  stars: 4,
  description: "Located on the Las Vegas Strip. This luxury hotel includes a full-service spa and wellness club. Guests enjoy a pool deck overlooking the Strip and a state-of-the-art casino.",
  price: 499.to_f,
  longitude: -115.134132,
  latitude: 36.181271
)

 Hotel.create(
  name: "Kimpton La Peer Hotel, an IHG Hotel",
  address: "627 N LA PEER DR, West Hollywood, Los Angeles, CA 90069, États-Unis",
  stars: 5,
  description: "Located on a tree-lined street in the West Hollywood design district. It offers an on-site restaurant and a pool for relaxing.",
  price: 405.to_f,
  longitude: -118.3617443,
  latitude: 34.0900091
 )
