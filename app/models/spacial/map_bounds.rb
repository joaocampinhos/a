module Spacial
  class MapBounds

    attr_reader :rectangle
    delegate :min_x, :max_x, :min_y, :max_y, to: :rectangle
    delegate :bl, :tr, to: :rectangle
    #delegate :area, to: :rectangle

    def initialize(rectangle)
      @rectangle = rectangle
    end

    def area
      width*height
    end

    def width
      tr_mercator = tr.to_mercator
      tl_mercator = tl.to_mercator
      tr_mercator.x - tl_mercator.x
    end

    def height
      tl_mercator = tl.to_mercator
      bl_mercator = bl.to_mercator
      tl_mercator.y - bl_mercator.y
    end

    def tl
      Geometry::GpsPoint.new(min_x, max_y)
    end

    def br
      Geometry::GpsPoint.new(max_x, min_y)
    end

    def query_condition
      %{
        ST_MakePolygon(
          ST_GeomFromText('LINESTRING(#{bl.x} #{bl.y},#{tl.x} #{tl.y},#{tr.x} #{tr.y},#{br.x} #{br.y},#{bl.x} #{bl.y})',4326)
        )
      }
    end

  end
end