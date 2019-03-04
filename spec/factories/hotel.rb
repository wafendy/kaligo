FactoryBot.define do
  factory :hotel do
    id { FFaker::BaconIpsum.word }
    destination_id { (1000..3000).to_a.sample }
    name { FFaker::Name.name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    country { FFaker::Address.country_code }
    postal_code { FFaker::AddressUS.zip_code }
    description { FFaker::BaconIpsum.paragraph }
    lat { rand }
    lng { rand }
    amenities_general { FFaker::BaconIpsum.words }
    amenities_room { FFaker::BaconIpsum.words }
    booking_conditions { FFaker::BaconIpsum.paragraphs }
    images_rooms {  }
    images_site {  }
    images_amenities {  }
  end
end
