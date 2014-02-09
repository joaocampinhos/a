require 'factory_girl'

FactoryGirl.define do

  factory :latitude, class: Attribute do
    name 'latitude'
  end

  factory :longitude, class: Attribute do
    name 'longitude'
  end

end