namespace :suppliers do
  namespace :import do
    desc 'Import all Supplier 2 data API'
    task supplier_2: :environment do |task, args|
      response = RestClient.get 'https://api.myjson.com/bins/1fva3m'
      supplier_hotels = JSON.parse(response.body)

      hotels_array = []

      result = supplier_hotels.each do |supplier_hotel|
        supplier_id = supplier_hotel['hotel_id'].strip
        existing_amenities_general = Hotel.find_by(id: supplier_id).try(:amenities_general) || []
        existing_amenities_room = Hotel.find_by(id: supplier_id).try(:amenities_room) || []
        sanitized_amenities_general = Hotel.sanitize_amenities_general(supplier_hotel['amenities']['general'])
        sanitized_amenities_room = Hotel.sanitize_amenities_room(supplier_hotel['amenities']['room'])

        existing_name = Hotel.find_by(id: supplier_id).try(:name) || ''
        existing_description = Hotel.find_by(id: supplier_id).try(:description) || ''
        existing_address = Hotel.find_by(id: supplier_id).try(:address) || ''

        existing_images = Hotel.find_by(id: supplier_id).try(:images) || {}
        existing_booking_conditions = Hotel.find_by(id: supplier_id).try(:booking_conditions) || []

        hotel_json = {
          id: supplier_id,
          destination_id: supplier_hotel['destination_id'],
          name: [supplier_hotel['hotel_name'].try(:strip), existing_name].max_by(&:length),
          address: [supplier_hotel['location']['address'].try(:strip), existing_address].compact.max_by(&:length),
          country: supplier_hotel['location']['country'].try(:strip),
          description: [supplier_hotel['details'].try(:strip), existing_description].compact.max_by(&:length),
          amenities_general: sanitized_amenities_general.concat(existing_amenities_general).uniq,
          amenities_room: sanitized_amenities_room.concat(existing_amenities_room).uniq,
          images: existing_images.merge(supplier_hotel['images']),
          booking_conditions: supplier_hotel['booking_conditions'].concat(existing_booking_conditions).uniq
        }

        hotels_array << Hotel.new(hotel_json)
        Hotel.import hotels_array, on_duplicate_key_update: hotel_json.keys
      end
    end
  end
end
