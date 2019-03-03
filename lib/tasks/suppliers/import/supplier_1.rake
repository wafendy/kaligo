namespace :suppliers do
  namespace :import do
    desc 'Import all Supplier 1 data API'
    task supplier_1: :environment do |task, args|
      response = RestClient.get 'https://api.myjson.com/bins/gdmqa'
      supplier_hotels = JSON.parse(response.body)

      hotels_array = []

      result = supplier_hotels.each do |supplier_hotel|
        supplier_id = supplier_hotel['Id'].strip
        existing_amenities_general = Hotel.find_by(id: supplier_id).try(:amenities_general) || []
        existing_amenities_room = Hotel.find_by(id: supplier_id).try(:amenities_room) || []
        sanitized_amenities_general = Hotel.sanitize_amenities_general(supplier_hotel['Facilities'])
        sanitized_amenities_room = Hotel.sanitize_amenities_room(supplier_hotel['Facilities'])

        existing_name = Hotel.find_by(id: supplier_id).try(:name) || ''
        existing_description = Hotel.find_by(id: supplier_id).try(:description) || ''
        existing_address = Hotel.find_by(id: supplier_id).try(:address) || ''

        hotel_json = {
          id: supplier_id,
          destination_id: supplier_hotel['DestinationId'],
          name: [supplier_hotel['Name'].try(:strip), existing_name].compact.max_by(&:length),
          lat: supplier_hotel['Latitude'],
          lng: supplier_hotel['Longitude'],
          address: [supplier_hotel['Address'].try(:strip), existing_address].compact.max_by(&:length),
          city: supplier_hotel['City'].try(:strip),
          country: supplier_hotel['Country'].try(:strip),
          postal_code: supplier_hotel['PostalCode'].try(:strip),
          description: [supplier_hotel['Description'].try(:strip), existing_description].compact.max_by(&:length),
          amenities_general: sanitized_amenities_general.concat(existing_amenities_general).uniq,
          amenities_room: sanitized_amenities_room.concat(existing_amenities_room).uniq
        }

        hotels_array << Hotel.new(hotel_json)
        Hotel.import hotels_array, on_duplicate_key_update: hotel_json.keys
      end
    end
  end
end
