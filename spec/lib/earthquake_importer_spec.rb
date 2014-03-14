require 'spec_helper'

describe EarthquakeImporter do
  describe ".import" do
    it "requests the recent earthquakes from the usgs" do
      HTTParty.should_receive(:get).with("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt")
      EarthquakeImporter.import
    end

    it "inserts new records" do
      VCR.use_cassette('usgs') do
        -> { EarthquakeImporter.import }.should change(Earthquake, :count)
      end
    end

    it "does not duplicate records" do
      VCR.use_cassette('usgs') do
        -> { EarthquakeImporter.import }.should change(Earthquake, :count)
        -> { EarthquakeImporter.import }.should_not change(Earthquake, :count)
      end
    end
  end
end