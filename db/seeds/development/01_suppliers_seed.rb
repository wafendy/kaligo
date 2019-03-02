return unless Supplier.all.empty?
[
  { 
    name: 'Supplier 1',
    api_base_url: 'https://api.myjson.com/bins/gdmqa',
    column_maps: {}
  }, { 
    name: 'Supplier 2', 
    api_base_url: 'https://api.myjson.com/bins/1fva3m',
    column_maps: {}
  }, {
    name: 'Supplier 3',
    api_base_url: 'https://api.myjson.com/bins/j6kzm',
    column_maps: {}
  }
].each do |param|
  Supplier.create(**param)
  puts "Supplier #{param[:name]} has been created"
end


