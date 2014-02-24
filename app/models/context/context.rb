module Context
  class Context
    attr_reader :map, :visualization, :dataset
    
    def initialize(map: nil, visualization: nil, dataset: nil)
      @map = map
      @visualization = visualization
      @dataset = dataset
    end

    def gps_to_canvas(gps_p)
      map.map_to_canvas(gps_p)
    end

    def canvas_to_map(p)
      map.canvas_to_map(p)
    end

    def area
      map.area
    end

    def gps_to_mercator(gps_point)
      map.gps_to_mercator(gps_point)
    end

    def canvas_length_to_meter(length)
      canvas_point = Geometry::Point.new(length, 0)
      radius_gps = canvas_to_map(canvas_point)
      #binding.pry
      bounds = map.map_bounds
      radius_gps.to_mercator.distance_to(bounds.bl.to_mercator)
    end

    def data
      bounds_condition = map.bounds_query_condition
      data = dataset.get_data(bounds_condition)
      data.map do |point| 
        gps_p = Geometry::GpsPoint.new(point["longitude"].to_f, point["latitude"].to_f)
        { 
          point: gps_p,
          id: point["id"].to_i
        }
      end
    end
  end
end
