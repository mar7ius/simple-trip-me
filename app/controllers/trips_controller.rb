require "json"
require "open-uri"
require "amadeus"

class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :set_trip, only: [:step_one]

  def index
    @trips = policy_scope(Trip)
  end

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
    @destination = params[:destination]
    # raise
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.destination = "Californie"
    authorize @trip
    @trip.user = current_user
    departure = params[:trip][:departure_flight] == 'Paris' ? 'PAR' : 'TLS'
    arrival = params[:trip][:arrival_flight] == 'Los Angeles' ? 'LAX' : 'SFO'

    if @trip.save!
      redirect_to step_one_trip_path(@trip, departure: departure, arrival: arrival)
    else
      render :new
    end
  end

  def step_one #new
    TripFlight.destroy_all
    Flight.destroy_all
    amadeus = Amadeus::Client.new({
      client_id: "nXHIAKb8yz6m3otvA1MGO2ETNK3I0gtm",
      client_secret: "tTW6I4texIOPcBLr",
    })
    result_d = amadeus.shopping.flight_offers_search.get(originLocationCode: params[:departure], destinationLocationCode: params[:arrival], departureDate: @trip.start_date, adults: 1, nonStop: true)

    parsing = JSON.parse(result_d.body)["data"].first(3)

    parsing.each do |flight|
      Flight.create(
        duration: flight["itineraries"][0]["duration"],
        departure: flight["itineraries"][0]["segments"][0]["departure"]["iataCode"],
        arrival: flight["itineraries"][0]["segments"][0]["arrival"]["iataCode"],
        compagnie_name: flight["itineraries"][0]["segments"][0]["carrierCode"],
        departure_date: flight["itineraries"][0]["segments"][0]["departure"]["at"],
        arrival_date: flight["itineraries"][0]["segments"][0]["arrival"]["at"],
        departure_flight: true,
        price: flight["price"]["total"].to_i,
        airport_iata_code: flight["itineraries"][0]["segments"][0]["departure"]["iataCode"],
      )
    end
    result_a = amadeus.shopping.flight_offers_search.get(originLocationCode: params[:arrival], destinationLocationCode: params[:departure], departureDate: @trip.start_date + @trip.duration.days, adults: 1, nonStop: true)
    parsing = JSON.parse(result_a.body)["data"].first(3)
    parsing.each do |flight|
      Flight.create(
        duration: flight["itineraries"][0]["duration"],
        departure: flight["itineraries"][0]["segments"][0]["departure"]["iataCode"],
        arrival: flight["itineraries"][0]["segments"][0]["arrival"]["iataCode"],
        compagnie_name: flight["itineraries"][0]["segments"][0]["carrierCode"],
        departure_date: flight["itineraries"][0]["segments"][0]["departure"]["at"],
        arrival_date: flight["itineraries"][0]["segments"][0]["arrival"]["at"],
        departure_flight: false,
        price: flight["price"]["total"].to_i,
        airport_iata_code: flight["itineraries"][0]["segments"][0]["departure"]["iataCode"],
      )
    end

    @flight_departure = TripFlight.new
    @flight_departure_list = Flight.where(departure_flight: true)
    @flight_returning = TripFlight.new
    @flight_returning_list = Flight.where(departure_flight: false)

    authorize @trip
  end

  def flight_choice #create
    set_trip
    authorize @trip

    @trip_flight_departure = TripFlight.create!(trip: @trip, flight: Flight.find(params[:trip][:trip_flight_ids][1]))
    @trip_flight_returning = TripFlight.create!(trip: @trip, flight: Flight.find(params[:trip][:trip_flight_ids][2]))

    if @trip_flight_departure.save && @trip_flight_returning.save
      redirect_to step_two_trip_path(@trip)
    else
      render :step_one
    end
  end

  def step_two
    set_trip
    @trip_activities = TripActivity.new
    authorize @trip
  end

  def activity_choice
    TripActivity.destroy_all
    set_trip
    authorize @trip
    choosen_activities_ids = params[:trip][:trip_activity_ids].reject!(&:empty?)
    choosen_activities_ids.each do |activity_id|
      @activity = Activity.find(activity_id)
      @trip_activity = TripActivity.create!(trip: @trip, activity: @activity)
      @trip_activity.save
    end
    if @trip.activities.count == choosen_activities_ids.count
      # redirect_to step_three_trip_path(@trip)
      redirect_to show_map_trip_path(@trip)
    else
      render :step_two
    end
  end

  ## DISPLAY MAP WITH ACTIVITIES AND ROUTE :

  def show_map
    set_trip
    authorize @trip

    # set origin point - actualy, san francisco
    san_francisco = Activity.where(name: "San Francisco")
    # that bitch return an array, need the index 0:
    waypoints = []

    origin_point = "#{san_francisco[0].latitude}%2C#{san_francisco[0].longitude}%3A"
    # Build string of Requested coordinates :
    @trip.activities.each do |activity|
      waypoints << "#{activity.latitude}%2C#{activity.longitude}%3A"
    end

    trip_request = origin_point + waypoints.join + origin_point

    # API Call
    api_token = "UIJntIl4JdzoPutRU5kcksjwlzPSDGlR"
    tomtom_request = "https://api.tomtom.com/routing/1/calculateRoute/#{trip_request}/json?computeBestOrder=true&routeRepresentation=polyline&routeType=fastest&avoid=unpavedRoads&travelMode=car&vehicleCommercial=false&key=#{api_token}"
    response_serialized = URI.open(tomtom_request).read
    response = JSON.parse(response_serialized, object_class: OpenStruct)

    # ----------------------
    # add response error handeling by response.respond_to?(:routes) / else : render activity 'no routes find'
    # -----------------------

    # Exploiting results :
    @routes = [] # Contains all routes to pass to mapbox

    response.routes.first.legs.each do |leg|
      leg.points.each do |coordinates|
        @routes << [coordinates.longitude, coordinates.latitude]
      end
    end

    # # Fabrication d'un hash de data compilé complet // Essai 2:
    # @trip_summary_temp = []
    # @trip_summary = []

    # response.optimizedWaypoints.each do |waypoint|
    #   activity = Activity.find(@trip.activities[waypoint.optimizedIndex].id)
    #   @trip_summary_temp << {
    #     order: waypoint.providedIndex + 1,
    #     activity_id: activity.id,
    #     duration: activity.duration * 60,
    #   }
    # end

    # (1...(response.routes.first.legs.count - 1)).to_a.each do |step|

    #     paired_activity = @trip_summary_temp.shift(2)
    #     paired_activity << {
    #       from: paired_activity.first[:order],
    #       to: paired_activity.last[:order],
    #       travel_duration: response.routes.first.legs[step].summary.travelTimeInSeconds
    #     }
    #     @trip_summary << paired_activity

    # end

    # Fabrication d'un hash de data compilé complet :
    @trip_summary = {}
    @trip_summary[:totalWaypoints] = 0
    @trip_summary[:originPointActivityId] = san_francisco[0].id

    # /!\ Optimized = array de coord passé dans la requete // Provided = Ordre intineraire optimisé
    response.optimizedWaypoints.each do |waypoint|
      activity = Activity.find(@trip.activities[waypoint.optimizedIndex].id)
      # @trip_summary["waypoint#{waypoint.providedIndex}ActivityId".to_sym] = Activity.find(@trip.activities[waypoint.optimizedIndex].id).id
      @trip_summary[:totalWaypoints] += 1
      @trip_summary["waypoint#{waypoint.providedIndex + 1}ActivityId".to_sym] = activity.id
      @trip_summary["waypoint#{waypoint.providedIndex + 1}ActivityDuration".to_sym] = activity.duration * 60
    end
    @trip_summary[:finalPointActivityId] = san_francisco[0].id

    # Ajout des temps pour chaque etapes :
    @trip_summary[:travelTimeBetweenWaypoint] = [{
      originToWaypoint1: response.routes.first.legs.first.summary.travelTimeInSeconds,
    }]

    (1...(response.routes.first.legs.count - 1)).to_a.each do |step|
      @trip_summary[:travelTimeBetweenWaypoint].first["waypoint#{step}To#{step + 1}".to_sym] = response.routes.first.legs[step].summary.travelTimeInSeconds
    end

    @trip_summary[:travelTimeBetweenWaypoint].first[:lastWaypointToFinalPoint] = response.routes.first.legs.last.summary.travelTimeInSeconds

    # Building days distribution :
    @durations = []

    @durations << {
      type: "ride",
      from_id: san_francisco[0].id,
      # id: san_francisco[0].id,
      to_id: @trip_summary[:waypoint1ActivityId],
      duration: @trip_summary[:travelTimeBetweenWaypoint].first[:originToWaypoint1],
    }

    (1..@trip_summary[:totalWaypoints]).to_a.each do |numb|
      @durations << {
        type: "activity",
        id: @trip_summary["waypoint#{numb}ActivityId".to_sym],
        order: numb,
        duration: @trip_summary["waypoint#{numb}ActivityDuration".to_sym],
      }
      if @trip_summary[:travelTimeBetweenWaypoint].first.key?("waypoint#{numb}To#{numb + 1}".to_sym)
        @durations << {
          type: "ride",
          from_id: @trip_summary["waypoint#{numb}ActivityId".to_sym],
          to_id: @trip_summary["waypoint#{numb + 1}ActivityId".to_sym],
          duration: @trip_summary[:travelTimeBetweenWaypoint].first["waypoint#{numb}To#{numb + 1}".to_sym],
        }
      end
    end
    @durations << {
      type: "ride",
      from_id: @durations.last[:id],
      to_id: san_francisco[0].id,
      # id: san_francisco[0].id,
      duration: @trip_summary[:travelTimeBetweenWaypoint].first[:lastWaypointToFinalPoint],
    }

    @all_days = []
    day_constant = 28_800 # Seconds

    while @durations.any?
      remaining_time = day_constant
      trip_day = []
      total_duration = { totalDayDuration: 0 }

      if @durations.any? && @durations.first[:duration] > day_constant
        # binding.pry
        duration = @durations.first.dup
        duration[:duration] = remaining_time
        duration[:slicedInTwoDays] = true
        total_duration[:totalDayDuration] += duration[:duration]
        trip_day.push(duration)
        @durations.first[:duration] -= remaining_time
        remaining_time = 0

        # elsif @durations.any? && remaining_time > 120 * 60 # && @duration.first = trajet
        #   duration = @durations.first
        #   duration[:duration] = remaining_time
        #   duration[:slicedInTwoDays] = true
        #   total_duration[:totalDayDuration] += duration[:duration]
        #   trip_day.push(duration)
        #   @durations.first[:duration] = @durations.first[:duration] - remaining_time
      end

      while @durations.any? && (remaining_time - @durations.first[:duration]).positive?
        trip_day.push(@durations.first)
        total_duration[:totalDayDuration] += @durations.first[:duration]
        remaining_time -= @durations.first[:duration]
        @durations.shift
      end

      trip_day.push(total_duration)
      @all_days.push(trip_day) if trip_day.any?
    end
    # raise
    # Send dataset for markers
    @markers = @trip.activities.map do |waypoint|
      {
        lat: waypoint[:latitude],
        lng: waypoint[:longitude],
        info_window: render_to_string(partial: "shared/info_window", locals: { waypoint: waypoint }),
      }
    end
  end

  def step_three
    set_trip
    @hotel = Hotel.new
    authorize @trip
  end

  def hotel_choice
    set_trip
    authorize @trip
    @trip_hotel = TripHotel.create!(trip: @trip, hotel_id: params[:trip][:trip_hotel_ids])
    if @trip_hotel.save
      redirect_to show_trip_path(@trip)
    else
      render :step_three
    end
  end

  def edit
    authorize @trip
  end

  def update
    @trip.update(trip_params)
    authorize @trip
    redirect_to trip_path(@trip)
  end

  def destroy
    @trip.destroy
    authorize @trip
    redirect_to trips_path
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:start_date, :duration, :destination, :nb_people)
  end
end
