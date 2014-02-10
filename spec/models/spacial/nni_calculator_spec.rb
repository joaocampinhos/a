module Spacial

  describe NNICalculator do 
 
    describe '#nni' do 
      before :each do 
        points = build(:points)
        context = build(:context)
        @calculator = NNICalculator.new(points, context)
      end

      it 'returns the computed value' do 
        @calculator.nni.should be_within(0.1).of(2.29618778411)
      end
    end
  end
end