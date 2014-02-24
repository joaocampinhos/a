module Context
  class Map
    attr_reader :canvas, :map_bounds
    delegate :width, :height, to: :map_bounds
    delegate :width, :height, to: :canvas, prefix: true
    def initialize(canvas: nil, map_bounds: nil)
      @canvas = canvas
      @map_bounds = map_bounds
    end

    def area
      map_bounds.area
    end

    def bounds_query_condition
      map_bounds.query_condition
    end

    def gps_to_mercator(gps_point)
      p1 = map_bounds.bl.to_mercator
      p2 = gps_point.to_mercator
      Geometry::Point.new(p2.x-p1.x, p2.y-p1.y)
    end

    def canvas_to_map(canvas_point)
      bl_mercator = map_bounds.bl.to_mercator
      x_mercator = ((canvas_point.x * width) / canvas_width) + bl_mercator.x
      y_mercator = ((canvas_point.y * height) / canvas_height) + bl_mercator.y
      mercator_point = Geometry::Point.new(x_mercator, y_mercator)
      Geometry::GpsPoint.from_mercator(mercator_point)
    end


    def map_to_canvas(gps_point)
      mercator_point = gps_point.to_mercator
      mercator_bl = map_bounds.bl.to_mercator
      x = (mercator_point.x - mercator_bl.x) * canvas_width / width
      y = (mercator_point.y - mercator_bl.y) * canvas_height  / height
      Geometry::Point.new(x,y)
    end
  end
end