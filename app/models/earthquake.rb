class Earthquake < ActiveRecord::Base
  acts_as_geolocated lat: 'latitude', lng: 'longitude'
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
      within_radius(8047, lat, lon) # 5 miles ~ 8.0467km
    end
  }
end
