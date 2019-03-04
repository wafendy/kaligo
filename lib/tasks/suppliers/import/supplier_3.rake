namespace :suppliers do
  namespace :import do
    desc 'Import all Supplier 3 data API'
    task supplier_3: :environment do |task, args|
      response = RestClient.get 'https://api.myjson.com/bins/j6kzm'
      supplier_hotels = JSON.parse(response.body)

      hotels_array = []

      result = supplier_hotels.each do |supplier_hotel|
        supplier_id = supplier_hotel['id'].strip
        current_hotel = Hotel.find_by(id: supplier_id)

        existing_amenities_general = current_hotel.try(:amenities_general) || []
        existing_amenities_room = current_hotel.try(:amenities_room) || []
        sanitized_amenities_general = Hotel.sanitize_amenities_general(supplier_hotel['amenities'])
        sanitized_amenities_room = Hotel.sanitize_amenities_room(supplier_hotel['amenities'])

        existing_name = current_hotel.try(:name) || ''
        existing_description = current_hotel.try(:description) || ''
        existing_address = current_hotel.try(:address) || ''

        existing_images_rooms = current_hotel.try(:images_rooms) || []
        existing_images_amenities = current_hotel.try(:images_amenities) || []

        sanitized_images_rooms = supplier_hotel['images']['rooms'].map do |img|
          {
            link: img['url'],
            description: img['description']
          }
        end
        sanitized_images_amenities = supplier_hotel['images']['amenities'].map do |img|
          {
            link: img['url'],
            description: img['description']
          }
        end

        hotel_json = {
          id: supplier_id,
          destination_id: supplier_hotel['destination'],
          name: [supplier_hotel['name'].try(:strip), existing_name].max_by(&:length),
          lat: supplier_hotel['lat'],
          lng: supplier_hotel['lng'],
          address: [supplier_hotel['address'].try(:strip), existing_address].compact.max_by(&:length),
          description: [supplier_hotel['info'].try(:strip), existing_description].compact.max_by(&:length),
          amenities_general: sanitized_amenities_general.concat(existing_amenities_general).uniq,
          amenities_room: sanitized_amenities_room.concat(existing_amenities_room).uniq,
          images_rooms: sanitized_images_rooms.concat(existing_images_rooms),
          images_amenities: sanitized_images_amenities.concat(existing_images_amenities)
        }

        hotels_array << Hotel.new(hotel_json)
        Hotel.import hotels_array, on_duplicate_key_update: hotel_json.keys
      end
    end
  end
end
