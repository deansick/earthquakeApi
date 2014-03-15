class Earthquake < ActiveRecord::Base
  acts_as_geolocated lat: 'latitude', lng: 'longitude'
  validates_uniqueness_of :usgs_eqid
  
  scope :since, ->(time=nil) {
    unless time.blank?
      time = Time.at(time.to_i).utc
      where("reported_date > ?", time)
    end
  }

  scope :on, ->(date=nil) {
    unless date.blank?
      parsed = Time.at(date.to_i).to_datetime
      where(reported_date: parsed.beginning_of_day..parsed.end_of_day)
    end
  }

  scope :over, ->(threshold=nil) {
    where("magnitude > ?", threshold) unless threshold.blank?
  }

  scope :near, ->(lat=nil, lon=nil) {
    unless lat.blank? || lon.blank?
      within_radius(8047, lat, lon) # 5 miles ~ 8.0467km
    end
  }
end
