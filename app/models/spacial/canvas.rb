module Spacial

  class Canvas


    attr_reader :rectangle
    delegate :width, :height, :origin, to: :rectangle
    delegate :max_x, :max_y, to: :rectangle

    def initialize(rectangle)
      @rectangle = rectangle
    end

    def split
      sub_width = width/2.0
      sub_height = height/2.0
      sw = Canvas.new(build_rectangle(sub_width, sub_height, Point.new(origin.x, origin.y)))
      nw = Canvas.new(build_rectangle(sub_width, sub_height, Point.new(origin.x, origin.y+sub_height)))
      ne = Canvas.new(build_rectangle(sub_width, sub_height, Point.new(origin.x+sub_width, origin.y+sub_height)))
      se = Canvas.new(build_rectangle(sub_width, sub_height, Point.new(origin.x+sub_width, origin.y)))
      [sw, nw, ne, se]
    end

    def touches?(point, radius = 0)
      (point.x - radius) <= max_x &&
      (point.y - radius) <= max_y &&
      (point.x + radius) >= origin.x &&
      (point.y + radius) >= origin.y
    end
    
    protected

    def build_rectangle(width, height, origin)
      Rectangle.build_with_dimensions(width: width, height: height, origin: origin)
    end

  end

end