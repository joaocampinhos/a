class DatasetsController < ApplicationController

  def index 
    render json: Dataset.select("id, name")
  end

end
