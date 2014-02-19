require 'spec_helper'

module Geometry
  describe Rectangle do
    describe "#initialize" do
      subject do 
        bl = FactoryGirl.build(:point, x: 3, y: 1)
        tr = FactoryGirl.build(:point, x:5, y: 10)
        Rectangle.new(bl, tr)
      end
      its(:bottom_left) { should == FactoryGirl.build(:point, x: 3, y: 1) }
      its(:top_right) { should == FactoryGirl.build(:point, x:5, y: 10) }
      its(:top_left) { should == FactoryGirl.build(:point, x: 3, y: 10) }
      its(:bottom_right) { should == FactoryGirl.build(:point, x: 5, y: 1) }
    end
  end
end
