class CreateEarthquakes < ActiveRecord::Migration
  # Src,Eqid,Version,Datetime,Lat,Lon,Magnitude,Depth,NST,Region
  def change
    create_table :earthquakes do |t|
      t.timestamp :reported_date
      t.string :usgs_eqid, :unique => true, :null => false
      t.point :geopoint, :geographic => true
      t.float :latitude
      t.float :longitude
      t.float :depth, :null => false
      t.float :magnitude, :null => false
      t.string :region
      t.timestamps
    end
  end
end
