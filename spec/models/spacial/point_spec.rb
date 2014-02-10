require 'spec_helper'

module Spacial
  describe Point do 
    describe '#initialize' do 
      context 'when given coords hash' do 
        subject { Point.new(latitude: 41.6888, longitude: -8.6201)}
        its (:x) { should == -8.6201}
        its (:y) { should == 41.6888}
        its (:longitude) { should == -8.6201}
        its (:latitude) {should == 41.6888}
      end

      context 'when given x and y args' do 
        subject { Point.new(3,4) }
        its (:x) {should == 3}
        its (:y) { should == 4}
        its (:longitude) { should == 3}
        its (:latitude) {should == 4}
      end
    end

    describe '#linear_distance_to' do 
      before :each do 
        @origin = Point.new(3, 4)
      end

      context 'when destination is in the same place' do 
        it 'should return 0' do 
          distance = @origin.linear_distance_to(@origin)
          distance.should eq(0)
        end
      end

      context 'when destination is Point(5,1)' do 
        it 'should return Sqrt(13)' do 
          distance = @origin.linear_distance_to(Point.new(5,1))
          distance.should eq(Math::sqrt(13))
        end
      end

      context 'when destination is Point(10,2)' do 
        it 'should return Sqrt(53)' do 
          distance = @origin.linear_distance_to(Point.new(10,2))
          distance.should eq(Math::sqrt(53))
        end
      end
    end 

    describe '#gps_distance_to' do 
      before :each do 
        @origin = Point.new(-8.6201, 41.6888)
      end

      context 'when destination is in the same place' do 
        it 'should return 0' do 
          distance = @origin.gps_distance_to(@origin)
          distance.should be_within(0.1).of(0)
        end
      end

      context 'when destination is Point(-9.0171, 39.1422)' do 
        it 'should return 285.2' do 
          distance = @origin.gps_distance_to(Point.new(-9.0171, 39.1422))
          distance.should be_within(0.1).of(285.2)
        end
      end

      context 'when destination is Point(-8.0572, 40.7563)' do 
        it 'should return 113.9' do
          distance = @origin.gps_distance_to(Point.new(-8.0572, 40.7563))
          distance.should be_within(0.1).of(113.9)
        end
      end
    end
  end
end