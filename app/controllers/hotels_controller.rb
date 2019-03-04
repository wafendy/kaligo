class HotelsController < ApplicationController
  def index
    hotels = Hotel
               .for_hotels(params[:hotels])
               .for_destination(params[:destination])
    render json: HotelSerializer.new(hotels).serialized_json
  end
end
