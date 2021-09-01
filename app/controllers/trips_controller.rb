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
    @trip.destination = "California"
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
      client_id: ENV["AMADEUS_CLIENT_ID"],
      client_secret: ENV["AMADEUS_CLIENT_SECRET"],
    })
    result_d = amadeus.shopping.flight_offers_search.get(originLocationCode: params[:departure], destinationLocationCode: params[:arrival], departureDate: @trip.start_date, adults: 1, nonStop: true, excludedAirlineCodes: "BF")

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
    result_a = amadeus.shopping.flight_offers_search.get(originLocationCode: params[:arrival], destinationLocationCode: params[:departure], departureDate: @trip.start_date + @trip.duration.days, adults: 1, nonStop: true, excludedAirlineCodes: "BF")
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
    @san_francisco = Activity.where(name: "San Francisco") # return an array, need the index 0:

    waypoints = []

    origin_point = "#{@san_francisco[0].latitude}%2C#{@san_francisco[0].longitude}%3A"
    # Build string of Requested coordinates :
    @trip.activities.each do |activity|
      waypoints << "#{activity.latitude}%2C#{activity.longitude}%3A"
    end

    trip_request = origin_point + waypoints.join + origin_point
    tomtom_api_call(trip_request)

    set_trip_summary
    day_distribution
    find_hotels_for_each_day

    # add hotels to the route drawn
    @trip.hotels.each do |hotel|
      waypoints << "#{hotel.latitude}%2C#{hotel.longitude}%3A"
    end
    trip_request = origin_point + waypoints.join + origin_point
    tomtom_api_call(trip_request)

    # raise

    # Send dataset for markers
    @markers = @trip.activities.map do |waypoint|
      {
        lat: waypoint[:latitude],
        lng: waypoint[:longitude],
        info_window: render_to_string(partial: "shared/info_window", locals: { waypoint: waypoint }),
      }
    end
    @markers_hotels = @trip.hotels.map do |hotel|
      {
        lat: hotel[:latitude],
        lng: hotel[:longitude],
        # info_window: render_to_string(partial: "shared/info_window", locals: { waypoint: waypoint }),
        image_url: helpers.asset_url("hotel_marker.png"),
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

  def find_hotel(day)
    if day[-3][:type] == "ride"
      activity_lat = Activity.find(day[-3][:to_id]).latitude
      activity_long = Activity.find(day[-3][:to_id]).longitude
    end

    if day[-3][:type] == "activity"
      activity_lat = Activity.find(day[-3][:id]).latitude
      activity_long = Activity.find(day[-3][:id]).longitude
    end

    api_token = ENV["TOMTOM_API_TOKEN"]
    hotel_url = "https://api.tomtom.com/search/2/search/hotel.json?limit=10&lat=#{activity_lat}&lon=#{activity_long}&radius=30000&categorySet=7314&key=#{api_token}"
    hotel_serialized = URI.open(hotel_url).read
    hotel_detail = JSON.parse(hotel_serialized)
    hotel_detail["results"].keep_if { |result| result.key?("dataSources") }

    hotel_detail["results"].each do |hotel|
      poi_id = hotel["dataSources"]["poiDetails"].first["id"]
      poi_detail_url = "https://api.tomtom.com/search/2/poiDetails.json?key=#{api_token}&id=#{poi_id}"
      poi_detail_serialized = URI.open(poi_detail_url).read
      poi_detail = JSON.parse(poi_detail_serialized)

      next unless poi_detail["result"].key?("description")

      poi_id_photo = poi_detail["result"]["photos"]&.first&.dig("id")
      if poi_id_photo.nil?
        poi_photo_url = "https://via.placeholder.com/300"
      else
        poi_photo_url = "https://api.tomtom.com/search/2/poiPhoto?key=#{api_token}&id=#{poi_id_photo}&height=250&width=250"
      end

      @hotel = Hotel.create(
        address: "#{hotel["address"]["freeformAddress"]}, United-States",
        rating: (50..75).to_a.sample.fdiv(10),
        description: poi_detail["result"]["description"],
        price: "#{(50..120).to_a.sample}.#{(1..99).to_a.sample}".to_f,
        longitude: hotel["position"]["lon"],
        latitude: hotel["position"]["lat"],
        name: hotel["poi"]["name"],
        img_link: poi_photo_url,
      )
      break unless @hotel.nil?
    end
    TripHotel.create(trip: @trip, hotel: @hotel, day: day.last[:day])
  end

  def tomtom_api_call(trip_request)
    # API Call
    api_token = ENV["TOMTOM_API_TOKEN"]
    tomtom_request = "https://api.tomtom.com/routing/1/calculateRoute/#{trip_request}/json?computeBestOrder=true&routeRepresentation=polyline&routeType=fastest&avoid=unpavedRoads&travelMode=car&vehicleCommercial=false&key=#{api_token}"
    response_serialized = URI.open(tomtom_request).read
    @response_tomtom = JSON.parse(response_serialized, object_class: OpenStruct)

    # ----------------------
    # add response error handeling by response.respond_to?(:routes) / else : render activity 'no routes find'
    # -----------------------

    # Exploiting results :
    @routes = [] # Contains all routes to pass to mapbox

    @response_tomtom.routes.first.legs.each do |leg|
      leg.points.each do |coordinates|
        @routes << [coordinates.longitude, coordinates.latitude]
      end
    end
  end

  def set_trip_summary
    # Fabrication d'un hash de data compilé complet :
    @trip_summary = {}
    @trip_summary[:totalWaypoints] = 0
    @trip_summary[:originPointActivityId] = @san_francisco[0].id

    # /!\ Optimized = array de coord passé dans la requete // Provided = Ordre intineraire optimisé
    @response_tomtom.optimizedWaypoints.each do |waypoint|
      activity = Activity.find(@trip.activities[waypoint.optimizedIndex].id)
      @trip_summary[:totalWaypoints] += 1
      @trip_summary["waypoint#{waypoint.providedIndex + 1}ActivityId".to_sym] = activity.id
      @trip_summary["waypoint#{waypoint.providedIndex + 1}ActivityDuration".to_sym] = activity.duration * 60
    end
    @trip_summary[:finalPointActivityId] = @san_francisco[0].id

    # Ajout des temps pour chaque etapes :
    @trip_summary[:travelTimeBetweenWaypoint] = [{
      originToWaypoint1: @response_tomtom.routes.first.legs.first.summary.travelTimeInSeconds,
    }]

    (1...(@response_tomtom.routes.first.legs.count - 1)).to_a.each do |step|
      @trip_summary[:travelTimeBetweenWaypoint].first["waypoint#{step}To#{step + 1}".to_sym] = @response_tomtom.routes.first.legs[step].summary.travelTimeInSeconds
    end

    @trip_summary[:travelTimeBetweenWaypoint].first[:lastWaypointToFinalPoint] = @response_tomtom.routes.first.legs.last.summary.travelTimeInSeconds
  end

  def day_distribution
    # Building days distribution :
    @durations = []

    @durations << {
      type: "ride",
      from_id: @san_francisco[0].id,
      # id: @san_francisco[0].id,
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
      to_id: @san_francisco[0].id,
      # id: @san_francisco[0].id,
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
  end

  def find_hotels_for_each_day
    TripHotel.where(trip: @trip).destroy_all
    day_increment = 1
    @all_days.each do |day|
      day << { day: day_increment }
      activities = day.pluck(:id).reject(&:nil?)
      if activities.any?
        activities.each { |id| TripActivity.where(trip_id: @trip, activity_id: id).update(day: day_increment) }
      end

      find_hotel(day)
      day_increment += 1
    end
  end
end
