class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels, id: :string do |t|
      t.column :destination_id, :integer
      t.column :name, :string
      t.column :location, :jsonb
      t.column :description, :text
      t.column :amenities, :jsonb
      t.column :images, :jsonb
      t.column :booking_conditions, :jsonb
      t.timestamps
    end

    add_index :hotels, :destination_id
  end
end