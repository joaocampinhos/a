require 'spec_helper'


module Spacial

  describe Box do 
    before :each do 
      bottom_left = Point.new(-9.0171, 39.1422)
      top_right = Point.new(-7.2404, 41.6888)
      @box = Box.new(bottom_left, top_right)
    end

    describe '#initialize' do 
      it 'has a bottom_left and top_right corners' do 
        expect(@box.bottom_left.latitude).to eq(39.1422)
        expect(@box.bottom_left.longitude).to eq(-9.0171)
        expect(@box.top_right.latitude).to eq(41.6888)
        expect(@box.top_right.longitude).to eq(-7.2404)
      end
    end

    describe '#area' do 
      it 'computes box area' do 
        @box.area.should be_within(0.1).of(147.529*283.169)
      end
    end

    describe '#bounding_query' do 
      it 'returns sql conditions for bounding box' do 
        query = 
        %{
          ST_MakePolygon(
            ST_GeomFromText(
              'LINESTRING(-9.0171 39.1422,-9.0171 41.6888,-7.2404 41.6888,-7.2404 39.1422,-9.0171 39.1422)',
              4326
              ))}
        expect(@box.bounding_query).to eq(query)
      end
    end
  end
end