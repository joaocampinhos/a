class DatasetsController < ApplicationController


  def index 
    render json: Dataset.select("id, name")
  end

  def show 
    set = Dataset.find(params[:id])
    render json: set.get_data
  end

  def create
    dataset = Dataset.create(name: params[:id], label: params[:name])
    dataset.create_table
    
    tuples = SmarterCSV.process(params[:file].path)

    tuples.each { |t| dataset.insert_tuple(t)}

    head :ok, content_type: 'text/html'
  end

end
