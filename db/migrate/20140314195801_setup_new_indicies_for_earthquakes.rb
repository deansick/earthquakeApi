class SetupNewIndiciesForEarthquakes < ActiveRecord::Migration
  def change
    add_earthdistance_index :earthquakes, {lat: :latitude, lng: :longitude}
    add_index :earthquakes, :usgs_eqid
  end
end
