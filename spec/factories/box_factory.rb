require 'factory_girl'

FactoryGirl.define do 

  factory :box, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:bottom_left), build(:top_right)) }
  end

  factory :pt_box, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:pt_bottom_left), build(:pt_top_right)) }
  end

  factory :pt_fit, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:pt_fit_bottom_left), build(:pt_fit_top_right))}
  end

  factory :pt_outer, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:pt_outer_bottom_left), build(:pt_outer_top_right))}
  end

  factory :uk_box, class: Spacial::Box do 
    initialize_with { Spacial::Box.new(build(:uk_bottom_left), build(:uk_top_right)) }
  end

end