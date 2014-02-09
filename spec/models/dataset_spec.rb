require 'spec_helper'

describe Dataset do
  before :each do 
    @dataset = FactoryGirl.build(:dataset)
  end

  describe '#get_data' do
    it 'should query data base with all attributes' do 
      ActiveRecord::Base.connection.should_receive(:execute)
      @dataset.get_data
    end
  end
end
