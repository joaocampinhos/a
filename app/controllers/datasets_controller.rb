class DatasetsController < ApplicationController


  def index 
    render json: Dataset.select("id, name, label")
  end

  def show 
    set = Dataset.find(params[:id])
    render json: set.get_data
  end

  def create
    dataset = Dataset.create(name: params[:name], label: params[:id])
    data = process_data(params[:file])
    dataset.create_table(data)
    head :ok, content_type: 'text/html'
  end

private

  def process_data(file)
    SmarterCSV.process(file.path)
  end


end
