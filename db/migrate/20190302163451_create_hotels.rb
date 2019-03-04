class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels, id: :string do |t|
      t.integer :destination_id
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :postal_code
      t.string :description
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :amenities_general, array: true, default: []
      t.string :amenities_room, array: true, default: []
      t.string :images_rooms, array: true, default: []
      t.string :images_site, array: true, default: []
      t.string :images_amenities, array: true, default: []
      t.text :booking_conditions, array: true, default: []
      t.timestamps
    end

    add_index :hotels, :destination_id
  end
end
