module Context
  class Context
    attr_reader :map, :visualization, :dataset
    
    def initialize(map: nil, visualization: nil, dataset: nil)
      @map = map
      @visualization = visualization
      @dataset = dataset

      p = Geometry::GpsPoint.new(-8.23232, 40.23232)
      pixel_p = map.map_to_canvas(p)
    end

  end
end
