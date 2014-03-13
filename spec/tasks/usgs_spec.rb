require 'spec_helper'
require 'rake'
require 'vcr'

describe 'usgs', :vcr => true do
  describe 'import' do
    before do
      load File.expand_path("../../../lib/tasks/usgs.rake", __FILE__)
    end
    
    it "fetches a list of recent earthquakes from the proper location" do
      VCR.use_cassette('earlier_records') do
        HTTParty.should_receive(:get).with("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt").and_call_original
        Rake::Task['usgs:import'].invoke
      end
    end
  end
end