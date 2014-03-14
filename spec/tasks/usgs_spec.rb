require 'spec_helper'
require 'rake'

describe 'usgs' do
  before do
    load File.expand_path("../../../lib/tasks/usgs.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end

  describe 'import' do
    it "invokes the earthquake importer" do
      EarthquakeImporter.should_receive(:import)
      Rake::Task['usgs:import'].invoke
    end
  end
end