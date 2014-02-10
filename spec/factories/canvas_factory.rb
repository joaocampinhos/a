require 'factory_girl'

FactoryGirl.define do 

  factory :canvas, class: Spacial::Canvas do 
    initialize_with { Spacial::Canvas.new(1000, 800)}
  end

end