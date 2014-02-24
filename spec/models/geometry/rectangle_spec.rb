require 'spec_helper'

describe Geometry::Rectangle do
  before :each do 
    bl = FactoryGirl.build(:point, x: 3, y: 1)
    tr = FactoryGirl.build(:point, x:5, y: 10)
    @rectangle = Geometry::Rectangle.build_with_bounds(bl: bl, tr: tr)  
  end
  describe "#initialize" do
    context 'with build_with_bounds' do 
      subject { @rectangle }
      its(:bottom_left) { should == FactoryGirl.build(:point, x: 3, y: 1) }
      its(:top_right) { should == FactoryGirl.build(:point, x:5, y: 10) }
      its(:top_left) { should == FactoryGirl.build(:point, x: 3, y: 10) }
      its(:bottom_right) { should == FactoryGirl.build(:point, x: 5, y: 1) }
    end
    context 'build_with_dimensions' do 
      subject do 
        origin = FactoryGirl.build(:point, x: 3, y: 1)
        Geometry::Rectangle.build_with_dimensions(width: 2, height: 9, origin: origin)
      end
      its(:bottom_left) { should == FactoryGirl.build(:point, x: 3, y: 1) }
      its(:top_right) { should == FactoryGirl.build(:point, x:5, y: 10) }
      its(:top_left) { should == FactoryGirl.build(:point, x: 3, y: 10) }
      its(:bottom_right) { should == FactoryGirl.build(:point, x: 5, y: 1) }
    end
  end

  describe "#area" do
    it 'return the area of the rectangle' do 
      expect(@rectangle.area).to eq(18)
    end
  end
end
