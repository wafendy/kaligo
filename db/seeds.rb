['common', Rails.env.to_s].each do |seeds_env|
  Dir.glob(Rails.root.join("db/seeds/#{seeds_env}/*_seed.rb")).sort.each do |f|
    load f
  end
end
  