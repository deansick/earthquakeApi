class AddIndiciesToEarthquakes < ActiveRecord::Migration
  def change
    add_index :earthquakes, :geopoint, :spatial => true
    add_index :earthquakes, :usgs_eqid
  end
end
