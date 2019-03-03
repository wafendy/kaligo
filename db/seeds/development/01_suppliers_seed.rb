return unless Supplier.all.empty?
[
  { 
    name: 'Supplier 1',
    api_base_url: 'https://api.myjson.com/bins/gdmqa',
    column_maps: {
      "id": "Id",
      "destination_id": "DestinationId",
      "name": "Name",
      "lat": "Latitude",
      "lng": "Longitude",
      "address": "Address",
      "city": "City",
      "country": "Country",
      "postal_code": "PostalCode",
      "description": "Description",
      "amenities_general": "Facilities",
      "amenities_room": "Facilities"   
    }
  }, { 
    name: 'Supplier 2', 
    api_base_url: 'https://api.myjson.com/bins/1fva3m',
    column_maps: {
      "id": "hotel_id",
      "destination_id": "destination_id",
      "name": "hotel_name",
      "address": "location,address",
      "country": "location,country",
      "description": "details",
      "amenities_general": "amenities,general",
      "amenities_room": "amenities,room"
    }
  }, {
    name: 'Supplier 3',
    api_base_url: 'https://api.myjson.com/bins/j6kzm',
    column_maps: {
      "destination_id": "destination",
      "lat": "location,address",
      "lng": "location,country",
      "description": "info",
      "amenities_general": "amenities"
    }
  }
].each do |param|
  Supplier.create(**param)
  puts "Supplier #{param[:name]} has been created"
end


