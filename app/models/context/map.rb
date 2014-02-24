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

    def canvas_to_map(length)
      length_in_meter = (length * width) / canvas_width
      bl_canvas = canvas.project(map_bounds.bl)
      length_in_meter - bl_canvas.x
    end

    def map_to_canvas(gps_point)
      mercator_point = gps_point.to_mercator
      mercator_bl = map_bounds.bl.to_mercator
      x = (mercator_point.x - mercator_bl.x) * canvas_width / width
      y = (mercator_point.y - mercator_bl.y) * canvas_height  / height
      binding.pry
      Geometry::Point.new(x,y)
    end
  end
end