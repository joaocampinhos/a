class StatisticsController < ApplicationController

  def index
    statistics = [{id: 'nni', name: 'Nearest Neighbour'}, {id: 'pcf', name: 'Pixel Collision Frequency'}]
    render json: statistics
  end

  def show
    context = build_context(params[:context])
  end

protected
  def build_context(context_data)
    map_data = fetch_value(context_data, :map)
    visualization = fetch_value(context_data, :visualization)
    dataset_id = fetch_value(context_data, :dataset)
    
    Spacial::Context.new
  end

  def fetch_value(hash, key)
    hash[key] || hash[key.to_s]
  end

end
