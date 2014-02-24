module Context
  class Context
    def initialize(map: nil, visualization: nil, dataset: nil)
      @map = map
      @visualization = visualization
      @dataset = dataset
    end
  end
end
