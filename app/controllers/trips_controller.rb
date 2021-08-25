require 'json'
require 'open-uri'
require 'amadeus'

class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new ]

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
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    @trip.user = current_user
    if @trip.save
      redirect_to step_one_trip_path(@trip)
    else
      render :new
    end
  end

  def step_one #new
    amadeus = Amadeus::Client.new({
      client_id: 'eswpB1iV5JFtkn4KWssBCAQsc4jdSQsh',
      client_secret: 'Q1PG0GhWGtDcmN4N'
     })
    result = amadeus.reference_data.urls.checkin_links.get(airlineCode: 'BA')
    parsing = JSON.parse(result.body)
    raise
    set_trip
    @flight_departure = TripFlight.new
    @flight_departure_list = Flight.where(departure_flight: true)
    @flight_returning = TripFlight.new
    @flight_returning_list = Flight.where(departure_flight: false)

    authorize @trip
  end

  def flight_choice #create
    set_trip
    authorize @trip
    @trip_flight = TripFlight.create!(trip: @trip, flight: params[:trip][:trip_flight_ids][1])
    raise

    if @trip_flight.save

      redirect_to step_two_trip_path(@trip)
    else
      render :step_one
    end
  end

  def step_two
    set_trip
    @activity = Activity.new
    authorize @trip
  end

  def activity_choice
    set_trip
    authorize @trip
    @trip_activity = TripActivity.create!(trip: @trip, activity_id: params[:trip][:trip_activity_ids])
    if @trip_activity.save
      redirect_to step_three_trip_path(@trip)
    else
      render :step_two
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
