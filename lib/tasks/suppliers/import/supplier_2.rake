namespace :suppliers do
  namespace :import do
    desc 'Import all Supplier 2 data API'
    task supplier_2: :environment do |task, args|
      response = RestClient.get 'https://api.myjson.com/bins/1fva3m'
      supplier_hotels = JSON.parse(response.body)

      hotels_array = []

      result = supplier_hotels.each do |supplier_hotel|
        supplier_id = supplier_hotel['hotel_id'].strip
        current_hotel = Hotel.find_by(id: supplier_id)

        existing_amenities_general = current_hotel.try(:amenities_general) || []
        existing_amenities_room = current_hotel.try(:amenities_room) || []
        sanitized_amenities_general = Hotel.sanitize_amenities_general(supplier_hotel['amenities']['general'])
        sanitized_amenities_room = Hotel.sanitize_amenities_room(supplier_hotel['amenities']['room'])

        existing_name = current_hotel.try(:name) || ''
        existing_description = current_hotel.try(:description) || ''
        existing_address = current_hotel.try(:address) || ''

        existing_booking_conditions = current_hotel.try(:booking_conditions) || []

        existing_images_rooms = current_hotel.try(:images_rooms) || []
        existing_images_site = current_hotel.try(:images_site) || []

        sanitized_images_rooms = supplier_hotel['images']['rooms'].map do |img|
          {
            link: img['link'],
            description: img['caption']
          }
        end
        sanitized_images_site = supplier_hotel['images']['site'].map do |img|
          {
            link: img['link'],
            description: img['caption']
          }
        end

        hotel_json = {
          id: supplier_id,
          destination_id: supplier_hotel['destination_id'],
          name: [supplier_hotel['hotel_name'].try(:strip), existing_name].max_by(&:length),
          address: [supplier_hotel['location']['address'].try(:strip), existing_address].compact.max_by(&:length),
          country: supplier_hotel['location']['country'].try(:strip),
          description: [supplier_hotel['details'].try(:strip), existing_description].compact.max_by(&:length),
          amenities_general: sanitized_amenities_general.concat(existing_amenities_general).uniq,
          amenities_room: sanitized_amenities_room.concat(existing_amenities_room).uniq,
          images_rooms: sanitized_images_rooms.concat(existing_images_rooms),
          images_site: sanitized_images_site.concat(existing_images_site),
          booking_conditions: supplier_hotel['booking_conditions'].concat(existing_booking_conditions).uniq
        }

        hotels_array << Hotel.new(hotel_json)
        Hotel.import hotels_array, on_duplicate_key_update: hotel_json.keys
      end
    end
  end
end
