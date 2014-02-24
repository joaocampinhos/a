module Spacial
  class MapBounds

    attr_reader :rectangle
    delegate :min_x, :max_x, :min_y, :max_y, to: :rectangle
    delegate :bl, :tl, :tr, :br, to: :rectangle

    def initialize(rectangle)
      @rectangle = rectangle
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