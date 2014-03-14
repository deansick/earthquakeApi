namespace :usgs do
  task :import => :environment do
    EarthquakeImporter.import
  end
end