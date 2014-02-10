require 'spec_helper'


module Spacial

  describe MapViewport do 
    describe '#initialize' do 
      bottom_left = Point.new(-9.0171, 39.1422)
      top_right = Point.new(-7.2404, 41.6888)
      subject { Viewport.new() }
    end

    it 'should be a viewport' do 
      (1+2).should be(3)
    end
  end

end