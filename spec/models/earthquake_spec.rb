require 'spec_helper'

describe Earthquake do
  describe "after_save" do
    it "preprocesses the sin and cos of latitude and longitude"
  end

  describe "scopes" do
    describe "since" do
      it "returns all records if a time is not given" do
        since_nil = Earthquake.since

        Earthquake.count.should == since_nil.length
      end

      it "returns records only after the specified date" do
        old_quake = Earthquake.make!( reported_date: 10.days.ago )
        new_quake = Earthquake.make!( reported_date: 1.day.ago )
        
        time = 2.days.ago.to_i
        earthquakes_since_time = Earthquake.since(time)

        earthquakes_since_time.should_not be_blank

        earthquakes_since_time.should include(new_quake)
        earthquakes_since_time.should_not include(old_quake)
      end
    end

    describe "on" do
      it "returns all records if no date is given" do
        on_nil = Earthquake.on

        Earthquake.count.should == on_nil.length
      end

      it "returns only earthquakes registered on the specified date" do
        yesterdays_quake = Earthquake.make!( reported_date: 1.day.ago )
        last_weeks_quake = Earthquake.make!( reported_date: 7.days.ago )

        date = 1.day.ago.to_i
        earthquakes_on_date = Earthquake.on(date)

        earthquakes_on_date.should_not be_blank

        earthquakes_on_date.should include(yesterdays_quake)
        earthquakes_on_date.should_not include(last_weeks_quake)
      end
    end

    describe "over" do
      it "returns all records if no threshold specified" do
        no_threshold = Earthquake.over

        Earthquake.count.should == no_threshold.count
      end

      it "returns only earthquakes bigger than the supplied threshold" do
        small_quake = Earthquake.make!( magnitude: 1.0 )
        big_quake = Earthquake.make!( magnitude: 5.0 )

        threshold = 3.3
        earthquakes_over_threshold = Earthquake.over(threshold)

        earthquakes_over_threshold.should_not be_blank

        earthquakes_over_threshold.should include(big_quake)
        earthquakes_over_threshold.should_not include(small_quake)
      end
    end

    describe "near" do
      it "returns all records if no lat/lon specified" do
        no_origin = Earthquake.near

        Earthquake.count.should == no_origin.length
      end

      it "returns only records within 5m/8km of the specified lat/lon" do
        nearby_quake = Earthquake.make!( latitude: 10.0, longitude: 10.0)
        far_away_quake = Earthquake.make!( latitude: -100.0, longitude: 10.1)

        quakes_near_location = Earthquake.near('10.0001,10.0001')

        quakes_near_location.should include(nearby_quake)
        quakes_near_location.should_not include(far_away_quake)
      end
    end
  end
end
