require 'factory_girl'

FactoryGirl.define do 
  factory :gps_point, class: Geometry::GpsPoint do 
    latitude 50.232452
    longitude -8.232423
    initialize_with { new(longitude, latitude) }
  end
end
