class HotelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_id, :name, :description, :booking_conditions

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

  attribute :images do |object|
    {
      rooms: object.images_rooms,
      site: object.images_site,
      amenities: object.images_amenities
    }
  end
end
