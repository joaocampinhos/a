require 'spec_helper'


module Spacial

  describe Canvas do 

    describe '#initialize' do 
      subject { Canvas.new(1000,800)}
      its (:width) { should == 1000}
      its (:height) { should == 800}
    end

  end
end