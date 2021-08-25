class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: :test

  def test
    # @activities = Activity.all
    @test_coordinates = [
      {
        longitude: -119.538329,
        latitude: 37.865101,
        name: "Yosemite",
      },
      {
        longitude: -118.243685,
        latitude: 34.052234,
        name: "Los Angeles",
      },
      {
        longitude: -116.881828,
        latitude: 36.513879,
        name: "Death Valley",
      },
      {
        longitude: -115.139830,
        latitude: 36.169941,
        name: "Las Vegas",
      },
      {
        longitude: -110.173479,
        latitude: 37.004245,
        name: "Monument Valley",
      },

    ]

    @test_route_json = [
      [
        -84.518399,
        39.134126,
      ],
      [
        -84.51841,
        39.133781,
      ],
      [
        -84.520024,
        39.133456,
      ],
      [
        -84.520321,
        39.132597,
      ],
      [
        -84.52085,
        39.128019,
      ],
      [
        -84.52036,
        39.127901,
      ],
      [
        -84.52094,
        39.122783,
      ],
      [
        -84.52022,
        39.122713,
      ],
      [
        -84.520768,
        39.120841,
      ],
      [
        -84.519639,
        39.120268,
      ],
      [
        -84.51233,
        39.114141,
      ],
      [
        -84.512652,
        39.11311,
      ],
      [
        -84.512399,
        39.112216,
      ],
      [
        -84.513232,
        39.112084,
      ],
      [
        -84.512127,
        39.107599,
      ],
      [
        -84.512904,
        39.107489,
      ],
      [
        -84.511692,
        39.102682,
      ],
      [
        -84.511987,
        39.102638,
      ],
    ]

    @markers = @test_coordinates.map do |waypoint|
      {
        lat: waypoint[:latitude],
        lng: waypoint[:longitude],
        info_window: render_to_string(partial: "shared/info_window", locals: { waypoint: waypoint }),
      }

    end
    @routes = @test_route_json
  end
end
