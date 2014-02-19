module Spacial
  class MapBounds

    POINT = Struct.new(:x, :y)
    attr_reader :bl, :tr
    alias_method :bottom_left, :bl
    alias_method :top_right, :tr
    alias_method :top_left, :tl
    alias_method :bottom_right, :br

    def initialize(bl, tr)
      @bl = bl
      @tr = tr
    end

    def tl
      build_point(min_x, max_y)
    end

    def br
      build_point(max_x, min_y)
    end

    def area
      side1 = point_distance(tl, bl)
      side2 = point_distance(tl, tr)
      side1*side2
    end

    def query_condition
      %{
        ST_MakePolygon(
          ST_GeomFromText('LINESTRING(#{bl.x} #{bl.y},#{tl.x} #{tl.y},#{tr.x} #{tr.y},#{br.x} #{br.y},#{bl.x} #{bl.y})',4326)
        )
      }
    end

private

    def min_x
      bl.x
    end

    def max_x
      tr.x
    end

    def min_y
      bl.y
    end

    def max_y
      tr.y
    end

    def build_point(x,y)
      Point.new(x, y)
    end

    def point_distance(p1, p2)
      p1.gps_distance_to(p2)
    end
  end
end