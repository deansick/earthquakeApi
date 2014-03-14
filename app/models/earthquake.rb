class Earthquake < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))

  validates_uniqueness_of :usgs_eqid
  
  scope :since, ->(time=nil) {
    unless time.blank?
      if time.kind_of?(Integer) || time.to_i > 12 # not a date/timestamp
        time = Time.at(time.to_i).to_datetime
      else
        time = DateTime.parse(time)
      end
      where("reported_date > ?", time)
    end
  }

  scope :on, ->(date=nil) {
    unless date.blank?
      if date.kind_of?(Integer) || date.to_i > 12
        parsed = Time.at(date.to_i).to_datetime
      else
        parsed = DateTime.parse(date)
      end
      where(reported_date: parsed.beginning_of_day..parsed.end_of_day)
    end
  }

  scope :over, ->(threshold=nil) {
    where("magnitude > ?", threshold) unless threshold.blank?
  }

  scope :near, ->(query=nil) {
    unless query.nil?
      lat,lon = query.split(',')
      where("ST_DWithin(Geography(geopoint), Geography(ST_MakePoint(?, ?)), 8047)", lon, lat) # 5 miles ~ 8.0467km
    end
  }
end
