require 'factory_girl'

FactoryGirl.define do 
  factory :context, class: Spacial::Context do 
    initialize_with { Spacial::Context.new(build(:box), build(:canvas)) }
  end
end