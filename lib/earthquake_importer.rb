require 'csv'

class EarthquakeImporter
  def self.import
    response = HTTParty.get("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt")
    return if response.blank?
    pi_180 = Math::PI / 180
    data = CSV.parse(response)[2..-1] # to remove the header and deprecation warning


    point_factory = RGeo::Geographic.simple_mercator_factory
    # Src,Eqid,Version,Datetime,Lat,Lon,Magnitude,Depth,NST,Region
    munged = data.collect do |src, eqid, version, report_time, lat, lon, magnitude, depth, nst, region|
      {
        usgs_eqid: eqid,
        reported_date: DateTime.parse(report_time),
        geopoint: point_factory.point(lon, lat),
        latitude: lat,
        longitude: lon,
        depth: depth,
        region: region,
        magnitude: magnitude,
      }
    end

    Earthquake.create(munged)
  end
end