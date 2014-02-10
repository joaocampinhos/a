require 'factory_girl'

FactoryGirl.define do 
  factory :points , class: Array do 
    initialize_with { [build(:place1), build(:place2), build(:place3), build(:place4)] }
  end

  factory :place1 , class: Hash do 
    longitude -8.6201
    latitude 41.6888
    initialize_with {attributes}
  end

  factory :place2 , class: Hash do 
    longitude -9.0171
    latitude 39.1422
    initialize_with {attributes}
  end

  factory :place3 , class: Hash do 
    longitude -7.2404
    latitude 40.4080
    initialize_with {attributes}
  end

  factory :place4 , class: Hash do 
    longitude -8.0572
    latitude 40.7563
    initialize_with {attributes}
  end


end