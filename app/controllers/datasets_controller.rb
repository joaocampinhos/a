class DatasetsController < ApplicationController

  def create
    head :ok, content_type: 'text/html'
  end

end
