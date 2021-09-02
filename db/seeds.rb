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
Trip.destroy_all

puts "creating default user"
User.create(email: "michel@gmail.com", password: "lewagon")

ACTIVITIES = [{
  name: "Yosemite",
  address: "Tioga Road Hwy 120 & Hwy 140 Yosemite National Park, CA 95389",
  longitude: -119.538329,
  latitude: 37.865101,
  category: 'National park',
  description: "Yosemite is an American national park, located in the Sierra Nevada Mountains in the eastern state of California. It is the third largest national park in California after Death Valley.",
  duration: 900,
  price: 35.to_f,
  code_image: "001"
  },

  {
  name: "Mariposa Museum",
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
  category: 'City',
  description: 'Located in the southern part of the state of California, 18.5 million people in its metropolitan area and 1,302 square kilometers of land, it is the second largest city in the United States.',
  duration: 1500,
  price: 00.to_f,
  code_image: "003"
  },

  {
  name: "Disneyland",
  address: "1313 Disneyland Dr, Anaheim, CA 92802, United-States",
  longitude: -117.923709,
  latitude: 33.815412,
  category: 'Amusement park',
  description: "Disneyland is a theme park located in the city of Anaheim, California, USA. Explore the magic of Disneyland and Disney California Adventure Park. About 30 miles southeast of Los Angeles.",
  duration: 420,
  price: 210.to_f,
  code_image: "004"
  },

  {
  name: "LACMA",
  address: " 5905 Wilshire Blvd, Los Angeles, CA 90036, United-States",
  longitude: -118.360565,
  latitude: 34.064251,
  category: 'Museum',
  description: "The Los Angeles County Museum of Art was originally the Museum of Science, History and Art, and has been dedicated to art since 1961.Located in the Miracle Mile neighborhood of Los Angeles.",
  duration: 180,
  price: 50.to_f,
  code_image: "005"
  },

    {
  name: "Universal Studios",
  address: "100 Universal City Plaza, Universal City, CA 91608, United-States",
  longitude: -118.351175,
  latitude: 34.135315,
  category: 'Amusement park',
  description: "Universal Studios Hollywood is a theme park in Universal City in Los Angeles. Located next to the Universal Studios owned by Universal Pictures, which is part of the tour with the Studio Tour.",
  duration: 420,
  price: 220.to_f,
  code_image: "006"
  },

  {
  name: "The Griffith Observatory ",
  address: "2800 E Observatory Rd, Los Angeles, CA 90027, United-States",
  longitude: -118.300463,
  latitude: 34.119311,
  category: 'Visit',
  description: "The hood ornament of Los Angeles, it serves as a public observatory, planetarium and exhibit space. Designed by some of its former employees, this tour give an introduction to the city.",
  duration: 120,
  price: 220.to_f,
  code_image: "007"
  },

  {
  name: "Hollywood Walk of Fame",
  address: "Hollywood Boulevard, Vine St, Los Angeles, CA 90028, United-States",
  longitude: -118.333694,
  latitude: 34.101639,
  category: 'Walk',
  description: "The Hollywood Walk of Fame is a famous sidewalk in the Hollywood neighborhood of the city of Los Angeles, featured on the sidewalk of this walk are badges, permanent public monuments.",
  duration: 120,
  price: 00.to_f,
  code_image: "008"
  },

    {
  name: "Hollywood Sign",
  address: "Los Angeles, Californie 90068, United-States",
  longitude: -118.320674,
  latitude: 34.134532,
  category: 'Walk',
  description: "The Hollywood Sign is more than just nine white letters spelling out a city's name. It’s one of the world's most famous monuments and a universal metaphor for ambition, success, glamour.",
  duration: 60,
  price: 00.to_f,
  code_image: "009"
  },

      {
  name: "Zoo Safari Park",
  address: " 15500 San Pasqual Valley Rd, Escondido, CA 92027, United-States",
  longitude: -117.002091,
  latitude: 33.095548,
  category: 'Zoological park',
  description: "San Diego Zoo Safari Park is a zoological park in San Pasqual Valley in San Diego. The park is home to a wide range of wild and endangered animals and species from every continent.",
  duration: 360,
  price: 320.to_f,
  code_image: "010"
  },

   {
  name: "Death Valley",
  address: "Furnace Creek, CA 92328, United-States",
  longitude: -116.808972,
  latitude: 36.421045,
  category: 'National park',
  description: "Death Valley National Park is located east of the Sierra Nevada Mountains in California and extends into Nevada. It is an arid zone park and contains the largest desert terrain in US.",
  duration: 360,
  price: 25.to_f,
  code_image: "011"
  },

  {
  name: "Red Rock Canyon",
  address: "1000 Scenic Loop Dr, Las Vegas, NV 89161, United-States",
  longitude: -115.423827,
  latitude: 36.132108,
  category: 'National park',
  description: "Red Rock Canyon is located 20 km west of Las Vegas (Nevada) in the southwestern US. It belongs to the arid environment of the Mojave Desert. It presents one of the walls of red sandstone.",
  duration: 180,
  price: 15.to_f,
  code_image: "012"
  },

  {
  name: "Las Vegas",
  address: "Las Vegas California, United-States",
  longitude: -115.139830,
  latitude: 36.169941,
  category: 'City',
  description: "Located in a valley on the borders of California, Arizona and Utah, Las Vegas is surrounded by mountains. One of the largest U.S. cities of Nevada and a major economic and tourist center.",
  duration: 1500,
  price: 00.to_f,
  code_image: "013"
  },

  {
  name: "Cirque du soleil shows",
  address: "Bellagio Drive, Las Vegas, NV 89109, United-States",
  longitude: -115.1743,
  latitude: 36.11157,
  category: 'Show',
  description: "Immerse yourself in the world of O, the original show from Cirque du Soleil's at the Bellagio that ranks among the top activities in Las Vegas. Rated one of the best things to do in Las Vegas.",
  duration: 90,
  price: 193.to_f,
  code_image: "014"
  },

  {
  name: "Monument Valley",
  address: "Indian Route 42, Oljato-Monument Valley, AZ 84536, United-States",
  longitude: -110.173479,
  latitude: 37.004245,
  category: 'Tribal park',
  description: "Monument Valley is an American natural site located on the border between Arizona and Utah, near the Four Corners. It is remarkable by its geomorphological formations (mesas and buttes).",
  duration: 360,
  price: 20.to_f,
  code_image: "015"
  },

  {
  name: "San Francisco",
  address: " San Francisco California, United-States",
  longitude: -122.431297,
  latitude: 37.773972,
  category: 'City',
  description: "A large city located on the west coast of the US of America (California). It is famous for its permanent fog, the iconic Golden Gate Bridge, its Cable Cars and its colorful Victorian houses.",
  duration: 900,
  price: 00.to_f,
  code_image: "016"
  },

  {
  name: "Golden Gate Bridge",
  address: "Golden Gate Bridge, San Francisco, CA, United-States ",
  longitude: -122.47872,
  latitude: 37.82034,
  category: 'Walk',
  description: "The Golden Gate Bridge is a suspension bridge (1.6 km) strait connecting San Francisco Bay and the Pacific. It connects the city oat the northern tip of the San Francisco to the city of Sausalito.",
  duration: 90,
  price: 16.to_f,
  code_image: "017"
  },

  {
  name: "Alcatraz",
  address: "San Francisco, Californie 94133, United-States",
  longitude: -122.41074,
  latitude: 37.81749,
  category: 'Museum',
  description: "The Rock was a maximum security federal prison on Alcatraz Island, 1.25 miles off the coast of San Francisco, It was named by the Spaniards because it served as a refuge for many pelicans.",
  duration: 180,
  price: 150.to_f,
  code_image: "018"
  },

  {
  name: "Pier 39",
  address: "The Embarcadero, San Francisco, CA 94133, United-States",
  longitude: -122.409821,
  latitude: 37.808673,
  category: 'Walk',
  description: "With family-friendly attractions, hotels and excellent restaurants, Fisherman's Wharf is a magnet for all visitors. Street performers and museums make this area a real postcard.",
  duration: 240,
  price: 00.to_f,
  code_image: "019"
  },

  {
  name: "Sequoia",
  address: "California, United-States",
  longitude: -118.59584,
  latitude: 36.45288,
  category: 'National park',
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
  category: 'Walk',
  description: "Jutting out into the Pacific Ocean at the intersection of Ocean and Colorado, it symbolizes the heart of Santa Monica and is one of the most photographed locations in the world..",
  duration: 120,
  price: 5.to_f,
  code_image: "021"
  },

  {
  name: "SeaWorld",
  address: "500 Sea World Dr., San Diego, CA 92109, United-States",
  longitude: -117.230969,
  latitude: 32.763173,
  category: 'Amusemet park',
  description: "SeaWorld San Diego is home to world-class animal shows, presentations and exhibits, spread out on beautiful Mission Bay Park. Discover the wonderful world of marine animals. ",
  duration: 240,
  price: 170.to_f,
  code_image: "022"
  },

  {
  name: "Lombard Street",
  address: "1070 Lombard Street between Jones St and Hyde St, San Francisco, CA 94109, United-States",
  longitude: -122.418892,
  latitude: 37.801945,
  category: 'Walk',
  description: "Lombard is a huge, heavily used street that runs through San Francisco from the Presidio to the Embarcadero. It is best known for a tiny one-block stretch in the Russia Hill neighborhood.",
  duration: 120,
  price: 00.to_f,
  code_image: "023"
  },

  {
  name: "The Hammer Museum",
  address: "10899 Wilshire Blvd., Los Ángeles, CA 90024, United-States",
  longitude: -118.262219,
  latitude: 34.032040,
  category: 'Museum',
  description: "The Hammer Museum is affiliated with the University of Los Angeles, and is an art museum and cultural center that exhibits a diverse collection of art from the Renaissance to the present.",
  duration: 180,
  price: 14.to_f,
  code_image: "024"
  },

  {
  name: "Mammoth Mountain",
  address: "10001 Minaret Road Mammoth Lakes, CA 93546, United-States",
  longitude: -119.039352,
  latitude: 37.650301,
  category: 'Walk',
  description: "Mammoth is a volcano that lies west of the town of Mammoth Lakes (Inyo National Forest), famous for its ski area and its strong snow cover due to its privileged location in the Sierra Nevada.",
  duration: 120,
  price: 00.to_f,
  code_image: "025"
  },

  {
  name: "Hoover Dam",
  address: "Boulder City, Nevada, United-States",
  longitude: -114.73745,
  latitude: 36.01613,
  category: 'Walk',
  description: "Hoover Dam is a concrete arch-gravity dam in the Black Canyon of the Colorado River, on the border between the United states of Nevada and Arizona. It was built between 1931 and 1936.",
  duration: 180,
  price: 5.to_f,
  code_image: "026"
  },

  {
  name: "Newport Landing",
  address: "309 Palm St A, Newport Beach, CA 92661, United-States ",
  longitude: -117.900461,
  latitude: 33.603225,
  category: 'Show',
  description: "Newport Landing is ideally positioned to take advantage of the annual Grey whale migration, which brings hundreds of Grey Whales along the Laguna Beach (largest marine protected parks).",
  duration: 120,
  price: 34.to_f,
  code_image: "027"
  },

  {
  name: "Muir Woods",
  address: "955 School Street Napa CA 94559, United-States",
  longitude: -122.2895309,
  latitude: 38.2973345,
  category: 'Excursion',
  description: "For one of the best wine tours in the country from San Francisco, combine a visit to Northern California's wine country with an experience at Muir Woods for a fabulous day (popular tours).",
  duration: 360,
  price: 260.to_f,
  code_image: "028"
  },

  {
  name: "Monterey",
  address: "3378-3404 17 Mile Dr, Pebble Beach, CA 93953, United-States",
  longitude: -121.931724,
  latitude: 36.563562,
  category: 'Scenic drive',
  description: "Drive the scenic Pacific Coast Highway to the Monterey Peninsula on this full-day trip from San Francisco, seeing Carmel and Pebble Beach Golf Course! Famous for its spectacular view.",
  duration: 660,
  price: 74.to_f,
  code_image: "029"
  },


  {
  name: "Catalina Island",
  address: "217 Metropole Ave, Avalon, CA 90704, United-States",
  longitude: -118.327857,
  latitude: 33.343317,
  category: 'Extreme sport',
  description: "Experience the thrill of soaring 600 feet above sea level through several high-speed zip lines on this incredible Catalina Island zip line eco-tour. Travel over 5 consecutive zip lines.",
  duration: 120,
  price: 230.to_f,
  code_image: "030"
  },
 ]

 puts "creating activities"
ACTIVITIES.each do |activity|
  Activity.create!(activity)
 end
