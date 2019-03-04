class Hotel < ApplicationRecord
  DB_COLUMNS = [
    'destination_id',
    'name',
    'address',
    'lat',
    'lng',
    'city',
    'country',
    'postal_code',
    'amenities_general',
    'amenities_room',
    'images',
    'booking_conditions'
  ].freeze

  AMENITIES_GENERAL = [
    'outdoor pool',
    'indoor pool',
    'pool',
    'business center',
    'childcare',
    'wifi',
    'dry cleaning',
    'breakfast'
  ].freeze

  AMENITIES_ROOM = [
    'aircon',
    'tv',
    'coffee machine',
    'kettle',
    'hair dryer',
    'iron',
    'bathtub'
  ].freeze

  scope :for_hotels, ->(hotel_ids) do
    return all if hotel_ids.blank?
    where(id: hotel_ids)
  end

  scope :for_destination, ->(destination_id) do
    return all if destination_id.blank?
    where(destination_id: destination_id)
  end

  def self.sanitize_amenities_general(original)
    return [] if original.nil?
    original.map do |k|
      if k.strip == 'WiFi'
        k.strip.downcase
      else
        k.strip.titleize.downcase
      end
    end.select{ |k| AMENITIES_GENERAL.include?(k) }
  end

  def self.sanitize_amenities_room(original)
    return [] if original.nil?
    original.map do |k|
      k.strip.titleize.downcase
    end.select{ |k| AMENITIES_ROOM.include?(k) }
  end
end
