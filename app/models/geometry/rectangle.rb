module Geometry

  class Rectangle

    attr_reader :bl, :tr

    def initialize(bl_point, tr_point)
      @bl = bl_point
      @tr = tr_point
    end

    def tl
      build_point(bl.x, tr.y)
    end

    def br
      build_point(tr.x, bl.y)
    end

    def area
      side1 = bl.distance_to(tl)
      side2 = tr.distance_to(tl)
      side1 * side2
    end

    alias_method :bottom_left, :bl
    alias_method :top_right, :tr
    alias_method :top_left, :tl 
    alias_method :bottom_right, :br 

    protected

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
  end
end