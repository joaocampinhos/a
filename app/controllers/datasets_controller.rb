class DatasetsController < ApplicationController


  def index 
    render json: Dataset.select("id, name")
  end
  
  def create
    head :ok, content_type: 'text/html'
  end

end
