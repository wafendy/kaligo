require 'rails_helper'

describe HotelSerializer do
  subject { HotelSerializer.new(hotel).serialized_json }

  let(:hotel) { create(:hotel) }

  let(:expected_result) do
    {
      data: {
        id: hotel.id,
        type: 'hotel',
        attributes: {
          destination_id: hotel.destination_id,
          name: hotel.name,
          description: hotel.description,
          images: hotel.images,
          booking_conditions: hotel.booking_conditions,
          location: {
            lat: hotel.lat.to_f,
            lng: hotel.lng.to_f,
            address: hotel.address,
            city: hotel.city,
            country: hotel.country
          },
          amenities: {
            general: hotel.amenities_general,
            room: hotel.amenities_room
          }
        }
      }
    }.to_json
  end

  it { is_expected.to eq expected_result }
end
