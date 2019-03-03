class Supplier < ApplicationRecord
  def get_mapped_column(name)
    (column_maps[name] || name).split(',')
  end
end
