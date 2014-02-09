require 'factory_girl'

FactoryGirl.define do
  
  factory :dataset do
    name 'fires'

    after :build do |dataset, evaluator|
      dataset.attributes << evaluator.build(:latitude)
      dataset.attributes << evaluator.build(:longitude)
    end
  end

end