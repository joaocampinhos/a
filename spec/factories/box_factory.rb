require 'factory_girl'

FactoryGirl.define do 

  factory :box, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:bottom_left), build(:top_right)) }
  end

  factory :pt_box, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:pt_bottom_left), build(:pt_top_right)) }
  end

end