require 'factory_girl'


FactoryGirl.define do 
  factory :point, class: Geometry::Point do 
    x 3
    y 6
    initialize_with { new(x,y) }
  end
end
