require 'spec_helper'

describe Geometry::Rectangle do
  before :each do 
    bl = FactoryGirl.build(:point, x: 3, y: 1)
    tr = FactoryGirl.build(:point, x:5, y: 10)
    @rectangle = Geometry::Rectangle.new(bl, tr)      
  end
  describe "#initialize" do
    subject { @rectangle }
    its(:bottom_left) { should == FactoryGirl.build(:point, x: 3, y: 1) }
    its(:top_right) { should == FactoryGirl.build(:point, x:5, y: 10) }
    its(:top_left) { should == FactoryGirl.build(:point, x: 3, y: 10) }
    its(:bottom_right) { should == FactoryGirl.build(:point, x: 5, y: 1) }
  end

  describe "#area" do
    it 'return the area of the rectangle' do 
      expect(@rectangle.area).to eq(18)
    end
  end
end
