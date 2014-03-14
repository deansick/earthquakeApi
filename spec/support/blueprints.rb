require 'machinist/active_record'


Earthquake.blueprint do
  region { Faker::Address.city }
  usgs_eqid { Faker::Code.isbn }
  reported_date { DateTime.now - rand(0.0..5.0).days }
  geopoint { RGeo::Geographic.simple_mercator_factory.point(rand(-180.0..180.0), rand(-180.0..180.0)) }
  depth { rand(0.1..10.0) }
  magnitude { rand(0.0..20.0) }
end

