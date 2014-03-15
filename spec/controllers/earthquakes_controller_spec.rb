require 'spec_helper'

describe EarthquakesController do
  before :each do
    @near = Earthquake.make!(longitude: 10.0, latitude: 10.0)
    @big = Earthquake.make!(magnitude: 8.0)
    @yesterday = Earthquake.make!(reported_date: 1.day.ago.utc )
    @two_days_ago = Earthquake.make!(reported_date: 2.days.ago.utc )
  end

  describe "index" do
    it "populates a list of quakes" do
      get :index
      assigns[:quakes].should_not be_blank
      assigns[:quakes].should include(@near, @big, @yesterday, @two_days_ago)
    end

    it "filters on dates with the 'on' param" do
      yesterday = 1.day.ago.utc.to_i

      get :index, on: yesterday
      assigns[:quakes].should include(@yesterday)
    end

    it "filters on times with the 'since' param" do
      since_time = 2.day.ago.utc.to_i

      get :index, since: since_time

      assigns[:quakes].should include(@yesterday)
      assigns[:quakes].should include(@two_days_ago)
    end

    it "can be both since and on" do
      since_time = 2.days.ago.utc.to_i

      get :index, since: since_time, on: since_time
      assigns[:quakes].should_not include(@yesterday)
      assigns[:quakes].should include(@two_days_ago)
    end

    it "finds quakes by size" do
      get :index, over: 5.0
      assigns[:quakes].should include(@big)
      assigns[:quakes].should_not include(@near, @yesterday, @two_days_ago)
    end

    it "finds quakes within a 5 mile radius of a given point" do
      get :index, near: '10.0001,10.00001'
      assigns[:quakes].should include(@near)
      assigns[:quakes].should_not include(@big, @yesterday, @two_days_ago)
    end
  end
end
