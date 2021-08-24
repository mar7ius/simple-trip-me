# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Flight.destroy_all
Activity.destroy_all

Flight.create!(departure: "LAX",
              arrival: 'CDG',
              departure_date: '10/07/2022',
              arrival_date: '18/07/2022',
              price: 100.00,
              duration: 10,
              departure_flight: true
            )
Flight.create!(departure: "JJJ",
              arrival: 'CDG',
              departure_date: '10/07/2022',
              arrival_date: '18/07/2022',
              price: 500.00,
              duration: 10,
              departure_flight: true
            )
Flight.create!(departure: "LML",
              arrival: 'CDG',
              departure_date: '10/07/2022',
              arrival_date: '18/07/2022',
              price: 700.00,
              duration: 10,
              departure_flight: true
            )


Activity.create!(address: "Death Valley National Park",
              stars: 5,
              description: 'Death Valley is the largest national park in the contiguous United States',
              price: 100.00,
              day: 1,
            )

Activity.create!(address: "Golden Gate Bridge",
              stars: 3,
              description: 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate',
              price: 50.00,
              day: 1,
            )

Activity.create!(address: "Hollywood Walk of Fame",
              stars: 4,
              description: 'Hollywood Chamber of Commerce is the awarding organization of the Hollywood Walk of Fame',
              price: 60.00,
              day: 1,
            )
