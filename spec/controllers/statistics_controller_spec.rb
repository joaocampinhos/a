require 'spec_helper'

describe StatisticsController do
  before :each do 
    @controller = StatisticsController.new
  end
  describe '#build_context' do 
    it 'builds a context object' do 
      bounds_data = {bl: {latitude: 50.322, longitude: -8.2323}, tr: {latitude: 52.23232423, longitude: -4.3232}}
      canvas_data = {width: 1000, height: 800}
      context_data = {map: {canvas: canvas_data,bounds: bounds_data}, visualization: {name: 'DotMap', params: {size: 3}}, dataset: 3}
      context = @controller.send(:build_context,context_data)
      expect(context).to be_a Spacial::Context
    end
  end
end
