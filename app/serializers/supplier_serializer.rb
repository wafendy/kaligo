class SupplierSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :api_base_url, :column_maps
end  