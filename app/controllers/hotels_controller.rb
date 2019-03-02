class HotelsController < ApplicationController
  def index
    hotels = Hotel.all
    render json: HotelSerializer.new(hotels).serialized_json
  end
end