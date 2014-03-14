require 'csv'

class EarthquakeImporter
  def self.import
    response = HTTParty.get("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt")
    return if response.blank?
    pi_180 = Math::PI / 180
    data = CSV.parse(response)[2..-1] # to remove the header and deprecation warning


    munged = data.collect do |src, eqid, version, report_time, lat, lon, magnitude, depth, nst, region|
      {
        usgs_eqid: eqid,
        reported_date: DateTime.parse(report_time),
        latitude: lat,
        longitude: lon,
        depth: depth,
        region: region,
        magnitude: magnitude,
      }
    end

    Earthquake.transaction do         # I went with wrapping in a transaction because it's marginally
      Earthquake.create(munged)       # faster than bulk creating as normal. I could have selected ids and
    end                               # excluded duplicates, pushing the inserts directly into sql.
  end                                 # That didn't seem appropriate.
end