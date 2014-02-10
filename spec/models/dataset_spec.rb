require 'spec_helper'

describe Dataset do
  before :each do 
    @dataset = build(:fires_dataset)
  end

  describe '#get_data' do

    it 'should query data base for latitude and longitude' do 
      ActiveRecord::Base.connection.should_receive(:execute).with("select * from fires")
      @dataset.get_data
    end

  end

  describe '#nni' do 

    it 'should compute nni for a given context' do 
      points = build(:points)
      @dataset.should_receive(:get_data).and_return(:points)
      nni = @dataset.compute_nni()
      
    end

  end

end
