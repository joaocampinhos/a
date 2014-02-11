module Spacial

  class Canvas
    
    attr_accessor :width, :height, :origin

    def initialize(width, height, origin = Point.new(0,0))
      @width = width
      @height = height
      @origin = origin
    end

    def split
      sub_width = width/2
      sub_height = height/2
      sw = Canvas.new(sub_width, sub_height, Point.new(@origin.x, @origin.y))
      nw = Canvas.new(sub_width, sub_height, Point.new(@origin.x, @origin.y+sub_height))
      ne = Canvas.new(sub_width, sub_height, Point.new(@origin.x+sub_width, @origin.y+sub_height))
      se = Canvas.new(sub_width, sub_height, Point.new(@origin.x+sub_width, @origin.y))
      [sw, nw, ne, se]
    end

    def touches?(point, radius = 0)
      (point.x - radius) <= max_x &&
      (point.y - radius) <= max_y &&
      (point.x + radius) >= origin.x &&
      (point.y + radius) >= origin.y
    end

    def project(gps_point)
      rad_point = gps_point.to_rad
      MERCATOR_PROJECTION.forward(rad_point)
    end

    def max_y
      @origin.y + @height
    end

    def max_x
      @origin.x + @width
    end

  end

end