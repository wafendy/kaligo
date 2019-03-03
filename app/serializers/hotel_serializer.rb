class HotelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :destination_id, :name, :description, :images, :booking_conditions

  attribute :location do |object|
    {
      lat: object.lat.to_f,
      lng: object.lng.to_f,
      address: object.address,
      city: object.city,
      country: object.country
    }
  end

  attribute :amenities do |object|
    {
      general: object.amenities_general,
      room: object.amenities_room
    }
  end
end
