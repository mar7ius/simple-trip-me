class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search ]

  def home
  end

  def search
    destination = params[:search][:destination]
    redirect_to new_trip_path(destination: destination)
  end
end
