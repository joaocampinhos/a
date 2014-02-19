require 'spec_helper'

module Geometry
  describe Point do
    describe "#initialize" do
      subject { Point.new(4,6)}
      its(:x) {should == 4 }
      its(:y) {should == 6 }
    end

    context 'public interface' do 
      before :each do 
        @subject = Point.new(2,5)
      end

      describe "#distance_to" do
        context 'same location' do 
          it 'returns 0' do 
            destination = Point.new(2,5)
            distance = @subject.distance_to(destination)
            expect(distance).to eq(0) 
          end
        end
        context 'diferent location' do 
          it 'returns the euclidean distance' do 
            destination = Point.new(1,7)
            distance = @subject.distance_to(destination)
            expect(distance).to eq(Math::sqrt(5)) 
          end
        end
      end

      describe '#==' do 
        context 'same location' do 
          it 'is true' do 
            other = Point.new(2,5)
            expect(@subject==other).to be_true
          end
        end
        context 'diferent location' do 
          it 'is false' do 
            other = Point.new(6,4)
            expect(@subject==other).to be_false
          end
        end
      end
    end
  end
end
