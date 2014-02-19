require 'spec_helper'

module Geometry
  describe GpsPoint do
    describe "#initialize" do
      context 'with x and y args' do 
        subject {GpsPoint.new(-8.342, 40.2324)}
        its (:longitude) {should == -8.342}
        its (:latitude) {should == 40.2324}
      end
      context 'with point arg' do 
        subject do 
          point = Point.new(-8.342, 40.2324)  
          GpsPoint.new(point)
        end
        its (:longitude) {should == -8.342}
        its (:latitude) {should == 40.2324}
      end
    end 

    context 'public interface' do 
      before :each do 
        @subject = GpsPoint.new(-8.6201, 41.6888)
      end

      describe "#distance_to" do
        context 'same location' do 
          it 'returns 0' do 
            destination =GpsPoint.new(-8.6201, 41.6888)
            distance = @subject.distance_to(destination)
            expect(distance).to be_within(0.1).of(0)
          end
        end
        context 'different location' do 
          it 'returns the haversine distance' do 
            destination = GpsPoint.new(-9.0171, 39.1422)
            distance = @subject.distance_to(destination)
            expect(distance).to be_within(0.1).of(285.2)
          end
        end
      end

      describe "#==" do
        context 'same location' do 
          it 'is true'
        end

        context 'different location' do 
          it 'is false' do
          end
        end
      end
      #end of public interface
    end
  end
end
