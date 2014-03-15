require 'machinist/active_record'


Earthquake.blueprint do
  region { Faker::Address.city }
  usgs_eqid { Faker::Code.isbn }
  reported_date { 3.days.ago }
  depth { 0.0 }
  longitude { 100.0 }
  latitude { 100.0 }
  magnitude { 0.0 }
end

