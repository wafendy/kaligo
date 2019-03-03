namespace :suppliers do
  namespace :import do
    desc 'Import all suppliers data API'
    task all: :environment do |task, args|
      Hotel.destroy_all
      Rake::Task['suppliers:import:supplier_1'].invoke
      Rake::Task['suppliers:import:supplier_2'].invoke
      Rake::Task['suppliers:import:supplier_3'].invoke
    end
  end
end
