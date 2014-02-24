module Geometry
  class Rectangle

    attr_reader :bl, :tr

    def tl
      Rectangle.build_point(bl.x, tr.y)
    end

    def br
      Rectangle.build_point(tr.x, bl.y)
    end

    def area
      side1 = bl.distance_to(tl)
      side2 = tr.distance_to(tl)
      side1 * side2
    end

    def width
      max_x - min_x
    end

    def height
      max_y - min_y
    end

    def max_y
      tr.y
    end

    def min_y
      bl.y
    end

    def max_x
      tr.x
    end

    def min_x
      bl.x
    end

    alias_method :bottom_left, :bl
    alias_method :top_right, :tr
    alias_method :top_left, :tl 
    alias_method :bottom_right, :br 

    def self.build_with_dimensions(width: 0, height: 0, origin: nil)
      bl = origin || Rectangle.build_point(0,0)
      tr = build_point(bl.x + width, bl.y + height)
      Rectangle.new(bl, tr)
    end

    def self.build_with_bounds(bl: nil, tr: nil)
      Rectangle.new(bl, tr)
    end

    private

    def initialize(bl_point, tr_point)
      @bl = bl_point
      @tr = tr_point
    end

    def build_rectangle(opts)

    end

    def self.build_point(x,y)
      Point.new(x,y)
    end
  end
end