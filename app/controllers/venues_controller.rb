class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :destroy, :edit, :update]

  def new
    @venue = Venue.new
  end

  def index
    @venues = Venue.all
    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude
      }
    end
  end

  def show
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to admin_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @venue.destroy
    redirect_to admin_path
  end

  def edit
    @hide_navbar = true
  end

  def update
    if @venue.update(venue_params)
      redirect_to admin_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address, :phone_number, :user_id, :photo, :time, :quizmaster, :day_of_the_week)
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end
end
