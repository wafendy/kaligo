class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.column :name, :string
      t.column :api_base_url, :string
      t.column :column_maps, :jsonb

      t.timestamps
    end
  end
end
