require 'factory_girl'

FactoryGirl.define do 
  factory :points , class: Array do 
    initialize_with { [build(:place1), build(:place2), build(:place3), build(:place4)] }
  end

  factory :place1 , class: Spacial::Point do 
    x -8.6201
    latitude 41.6888
    initialize_with {Spacial::Point.new(attributes)}
  end

  factory :place2 , class: Spacial::Point do 
    x -9.0171
    y 39.1422
    initialize_with {Spacial::Point.new(attributes)}
  end

  factory :place3 , class: Spacial::Point do 
    x -7.2404
    y 40.4080
    initialize_with {Spacial::Point.new(attributes)}
  end

  factory :place4 , class: Spacial::Point do 
    x -8.0572
    y 40.7563
    initialize_with {Spacial::Point.new(attributes)}
  end

  factory :bottom_left, class: Spacial::Point do 
    x -9.0171
    y 39.1422 
  end

  factory :top_right, class: Spacial::Point do 
    x -7.2404
    y 41.6888
  end

  factory :pt_bottom_left, class: Spacial::Point do 
    x -17.819824
    y 34.41597
  end

  factory :pt_top_right, class: Spacial::Point do 
    x 1.955566406
    y 44.5591634
  end
end