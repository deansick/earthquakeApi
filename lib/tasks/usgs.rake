require 'csv'

namespace :usgs do
  task :import do
    text = HTTParty.get("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt")
    data = CSV.parse(text)[2..-1] # to remove the header and deprecation warning
    
  end
end