# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Flight.destroy_all
Activity.destroy_all

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
  address: "Tioga Road Hwy 120 & Hwy 140 Yosemite National Park, CA 95389",
  longitude: -119.538329,
  latitude: 37.865101,
  category: 'national park',
  description: "Yosemite is an American national park, located in the Sierra Nevada Mountains in the eastern state of California.",
  duration: 900,
  price: 35.to_f,
  code_image: "001"
  },

  {
  name: "Mariposa Museum & History Center",
  address: "5119 Jessie St, Mariposa, CA 95338, United-States",
  longitude: -119.97116,
  latitude: 37.489475,
  category: 'Museum',
  description: "The Mariposa Museum & History Center is an award-winning small museum presents an authentic picture of people and life in Mariposa, concentrating on the Gold Rush and late 19th century.",
  duration: 90,
  price: 8.to_f,
  code_image: "002"
  },

  {
  name: "Los Angeles",
  address: "Los Angeles California, United-States",
  longitude: -118.243685,
  latitude: 34.052234,
  category: 'city',
  description: 'With more than 18.5 million people in its metropolitan area and 1,302 square kilometers of land, it is the second largest city in the United States.',
  duration: 1500,
  price: 00.to_f,
  code_image: "003"
  },

  {
  name: "Disneyland",
  address: "1313 Disneyland Dr, Anaheim, CA 92802, United-States",
  longitude: -117.923709,
  latitude: 33.815412,
  category: 'amusement park',
  description: "Explore the magic of Disneyland Park and Disney California Adventure Park.",
  duration: 360,
  price: 210.to_f,
  code_image: "004"
  },

  {
  name: "LACMA (Los Angeles County Museum of Art)",
  address: " 5905 Wilshire Blvd, Los Angeles, CA 90036, United-States",
  longitude: -118.360565,
  latitude: 34.064251,
  category: 'Museum',
  description: "The Los Angeles County Museum of Art was originally the Museum of Science, History and Art, and has been dedicated to art since 1961.",
  duration: 180,
  price: 50.to_f,
  code_image: "005"
  },

    {
  name: "Universal Studios Hollywood",
  address: "100 Universal City Plaza, Universal City, CA 91608, United-States",
  longitude: -118.351175,
  latitude: 34.135315,
  category: 'amusement park',
  description: "Universal Studios Hollywood is a theme park owned by NBC Universal and located in Universal City in the suburbs of Los Angeles, California. The park is located next to the Universal Studios owned by Universal Pictures, which is part of the tour with the Studio Tour.",
  duration: 420,
  price: 220.to_f,
  code_image: "006"
  },

  {
  name: "Private tour of the Griffith Observatory ",
  address: "2800 E Observatory Rd, Los Angeles, CA 90027, United-States",
  longitude: -118.300463,
  latitude: 34.119311,
  category: 'visit',
  description: " Called the hood ornament of Los Angeles, it serves as a public observatory, planetarium and exhibit space. Designed by some of its former employees, this tour will give you an introduction to the city you'll never forget. ",
  duration: 120,
  price: 220.to_f,
  code_image: "007"
  },

  {
  name: "Hollywood Walk of Fame",
  address: "Hollywood Boulevard, Vine St, Los Angeles, CA 90028, United-States",
  longitude: -118.333694,
  latitude: 34.101639,
  category: 'walk',
  description: "The Hollywood Walk of Fame is a famous sidewalk in the Hollywood neighborhood of the city of Los Angeles. Located on Hollywood Boulevard, featured on the sidewalk of this walk are badges, permanent public monuments, in the names of various celebrities in the entertainment industry.",
  duration: 120,
  price: 00.to_f,
  code_image: "008"
  },

    {
  name: "Hollywood Sign",
  address: "Los Angeles, Californie 90068, United-States",
  longitude: -118.320674,
  latitude: 34.134532,
  category: 'walk',
  description: "The Hollywood Sign is more than just nine white letters spelling out a city's name. It’s one of the world's most famous monuments and a universal metaphor for ambition, success, glamour.",
  duration: 60,
  price: 00.to_f,
  code_image: "009"
  },

      {
  name: "San Diego Zoo Safari Park",
  address: " 15500 San Pasqual Valley Rd, Escondido, CA 92027, United-States",
  longitude: -117.002091,
  latitude: 33.095548,
  category: 'zoological park',
  description: "San Diego Zoo Safari Park is a zoological park in San Pasqual Valley in San Diego, California, near Escondido. The park is home to a wide range of wild and endangered animals and species from every continent.",
  duration: 360,
  price: 320.to_f,
  code_image: "010"
  },

   {
  name: "Death Valley National Park",
  address: "Furnace Creek, CA 92328, United-States",
  longitude: -116.808972,
  latitude: 36.421045,
  category: 'national park',
  description: "Death Valley National Park is located east of the Sierra Nevada Mountains in California and extends into Nevada. It is an arid zone park and contains the largest desert terrain in the continental United States.",
  duration: 360,
  price: 25.to_f,
  code_image: "011"
  },

  {
  name: "Red Rock Canyon",
  address: "1000 Scenic Loop Dr, Las Vegas, NV 89161, United-States",
  longitude: -115.423827,
  latitude: 36.132108,
  category: 'national park',
  description: "Red Rock Canyon is located 20 km west of Las Vegas in the state of Nevada in the southwestern United States. It belongs to the arid environment of the Mojave Desert. ",
  duration: 180,
  price: 15.to_f,
  code_image: "012"
  },

  {
  name: "Las Vegas",
  address: "Las Vegas California, United-States",
  longitude: -115.139830,
  latitude: 36.169941,
  category: 'city',
  description: "Located in a valley on the borders of California, Arizona and Utah, Las Vegas is surrounded by snow-capped mountains in winter.",
  duration: 1500,
  price: 00.to_f,
  code_image: "013"
  },

  {
  name: "Las Vegas Cirque du soleil shows - Bellagio Hotel",
  address: "Bellagio Drive, Las Vegas, NV 89109, United-States",
  longitude: -115.1743,
  latitude: 36.11157,
  category: 'show',
  description: "Immerse yourself in the world of O, Cirque du Soleil's original water show at the Bellagio that ranks among the top activities in Las Vegas.",
  duration: 90,
  price: 193.to_f,
  code_image: "014"
  },

  {
  name: "Monument Valley",
  address: "Indn Route 42, Oljato-Monument Valley, AZ 84536, United-States",
  longitude: -110.173479,
  latitude: 37.004245,
  category: 'tribal park',
  description: "Monument Valley is an American natural site located on the border between Arizona and Utah, near the Four Corners. It is remarkable by its geomorphological formations composed in particular of mesas and buttes.",
  duration: 360,
  price: 20.to_f,
  code_image: "015"
  },

  {
  name: "San Francisco",
  address: " San Francisco California, United-States",
  longitude: -122.431297,
  latitude: 37.773972,
  category: 'city',
  description: "San Francisco is a large city located on the west coast of the United States of America, in the state of California.",
  duration: 900,
  price: 00.to_f,
  code_image: "016"
  },

  {
  name: "Golden Gate Bridge",
  address: "Golden Gate Bridge, San Francisco, CA, United-States ",
  longitude: -122.47872,
  latitude: 37.82034,
  category: 'walk',
  description: "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide (1.6 km) strait connecting San Francisco Bay and the Pacific Ocean.",
  duration: 90,
  price: 16.to_f,
  code_image: "017"
  },

    {
  name: "Alcatraz Federal Penitentiary",
  address: "San Francisco, Californie 94133, United-States",
  longitude: -122.41074,
  latitude: 37.81749,
  category: 'museum',
  description: "The Rock was a maximum security federal prison on Alcatraz Island, 1.25 miles (2.01 km) off the coast of San Francisco,",
  duration: 180,
  price: 150.to_f,
  code_image: "018"
  },

      {
  name: "Pier 39",
  address: "The Embarcadero, San Francisco, CA 94133, United-States",
  longitude: -122.409821,
  latitude: 37.808673,
  category: 'walk',
  description: "With family-friendly attractions, fine hotels and excellent restaurants, Fisherman's Wharf is a magnet for all visitors. Street performers, streetcars and museums make this area a real postcard.",
  duration: 240,
  price: 00.to_f,
  code_image: "019"
  },

    {
  name: "Sequoia National Park",
  address: "California, United-States",
  longitude: -118.59584,
  latitude: 36.45288,
  category: 'national park',
  description: "Sequoia National Park is located in the southern Sierra Nevada Mountains of California. It is known for its huge redwoods, including General Sherman, which dominates the Giant Forest.",
  duration: 400,
  price: 15.to_f,
  code_image: "020"
  },
     {
  name: "Santa Monica Pier",
  address: "200 Santa Monica Pier, Santa Monica, CA 90401, United-States",
  longitude: -118.497269,
  latitude: 34.008991,
  category: 'walk',
  description: "Jutting out into the Pacific Ocean at the intersection of Ocean and Colorado, it symbolizes the heart of Santa Monica and is one of the most photographed locations in the world..",
  duration: 120,
  price: 5.to_f,
  code_image: "021"
  },
      {
  name: "SeaWorld - San Diego",
  address: "500 Sea World Dr., San Diego, CA 92109, United-States",
  longitude: -117.230969,
  latitude: 32.763173,
  category: 'amusemet park',
  description: "SeaWorld San Diego is home to world-class animal shows, presentations and exhibits, spread out on beautiful Mission Bay Park.",
  duration: 240,
  price: 170.to_f,
  code_image: "022"
  },
     {
  name: "Lombard Street",
  address: "1070 Lombard Street between Jones St and Hyde St, San Francisco, CA 94109, United-States",
  longitude: -122.418892,
  latitude: 37.801945,
  category: 'walk',
  description: "Lombard is a huge, heavily used street that runs through San Francisco from the Presidio to the Embarcadero. It is best known for a tiny one-block stretch in the Russia Hill neighborhood, between Hyde St and Leavenworth. Eight sharp turns make it one of the most winding roads in the US (there is a debate with Snake Alley in Burlington, Iowa and Vermont Street, also in San Francisco, between 20th and 22nd).",
  duration: 120,
  price: 00.to_f,
  code_image: "023"
  },
      {
  name: "The Hammer Museum",
  address: "10899 Wilshire Blvd., Los Ángeles, CA 90024, United-States",
  longitude: -118.262219,
  latitude: 34.032040,
  category: 'museum',
  description: "The Hammer Museum is affiliated with the University of California, Los Angeles, and is an art museum and cultural center that exhibits a diverse collection of art from the Renaissance to the present",
  duration: 180,
  price: 14.to_f,
  code_image: "024"
  },
     {
  name: "Mammoth Mountain",
  address: "10001 Minaret Road Mammoth Lakes, CA 93546, United-States",
  longitude: -119.039352,
  latitude: 37.650301,
  category: 'walk',
  description: "Mammoth Mountain is a volcano that lies west of the town of Mammoth Lakes in the Inyo National Forest. Mammoth Mountain is famous for its ski area and its strong snow cover due to its privileged location in the Sierra Nevada..",
  duration: 120,
  price: 00.to_f,
  code_image: "025"
  },
      {
  name: "Hoover Dam",
  address: "Boulder City, Nevada, United-States",
  longitude: -114.73745,
  latitude: 36.01613,
  category: 'walk',
  description: "Hoover Dam is a concrete arch-gravity dam in the Black Canyon of the Colorado River, on the border between the U.S. states of Nevada and Arizona.",
  duration: 180,
  price: 5.to_f,
  code_image: "026"
  },
     {
  name: "Newport Landing Whale Watching",
  address: "309 Palm St A, Newport Beach, CA 92661, United-States ",
  longitude: -117.900461,
  latitude: 33.603225,
  category: 'show',
  description: "Newport Landing is ideally positioned to take advantage of the annual Grey whale migration, which brings hundreds of Grey Whales along the Laguna Beach.",
  duration: 120,
  price: 34.to_f,
  code_image: "027"
  },
      {
  name: "Excursion to Muir Woods and the vineyards ",
  address: "955 School Street Napa CA 94559, United-States",
  longitude: -122.2895309,
  latitude: 38.2973345,
  category: 'excursion',
  description: "For one of the best wine tours in the country from San Francisco, combine a visit to Northern California's wine country with an experience at Muir Woods for a fabulous day out.",
  duration: 360,
  price: 260.to_f,
  code_image: "028"
  },
     {
  name: "Monterey & Carmel Tours",
  address: "3378-3404 17 Mile Dr, Pebble Beach, CA 93953, United-States",
  longitude: -121.931724,
  latitude: 36.563562,
  category: 'Scenic drive',
  description: "Drive the scenic Pacific Coast Highway to the Monterey Peninsula on this full-day trip from San Francisco, seeing Carmel and Pebble Beach Golf Course!",
  duration: 660,
  price: 74.to_f,
  code_image: "029"
  },

     {
  name: "Tyrolean traverse on Catalina Island",
  address: "217 Metropole Ave, Avalon, CA 90704, United-States",
  longitude: -118.327857,
  latitude: 33.343317,
  category: 'extreme sport',
  description: "Experience the thrill of soaring 600 feet above sea level through several high-speed zip lines on this incredible Catalina Island zip line eco-tour. .",
  duration: 120,
  price: 230.to_f,
  code_image: "030"
  },
 ]

 puts "creating activities :"
ACTIVITIES.each do |activity|
  Activity.create!(activity)
 end


# puts "creating hotels :"
Hotel.create(
  name: "St. Regis San Francisco",
  address: "125 Third Street, San Francisco, CA 94103, United-States",
  stars: 5,
  description: "Located in San Francisco's SoMa neighborhood, The St. Regis San Francisco features a full-service spa, an infinity pool and an on-site restaurant. This luxury hotel has rooms with flat-screen TVs. Union Square is an 8-minute walk away.",
  price: 525.to_f,
  longitude: -122.401322,
  latitude: 37.786314
 )

Hotel.create(
  name: "The Palazzo at The Venetian",
  address: "3325 Las Vegas Boulevard South, Strip, Las Vegas, NV 89109, United-States",
  stars: 4,
  description: "Located on the Las Vegas Strip. This luxury hotel includes a full-service spa and wellness club. Guests enjoy a pool deck overlooking the Strip and a state-of-the-art casino.",
  price: 499.to_f,
  longitude: -115.134132,
  latitude: 36.181271
)

 Hotel.create(
  name: "Kimpton La Peer Hotel, an IHG Hotel",
  address: "627 N LA PEER DR, West Hollywood, Los Angeles, CA 90069, United-States",
  stars: 5,
  description: "Located on a tree-lined street in the West Hollywood design district. It offers an on-site restaurant and a pool for relaxing.",
  price: 405.to_f,
  longitude: -118.3617443,
  latitude: 34.0900091
 )
