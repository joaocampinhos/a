module Spacial

  class Box
    attr_accessor :bottom_left, :top_right

    def initialize(bottom_left, top_right)
      @bottom_left = bottom_left
      @top_right = top_right
    end

    def area 
      top_left = Point.new(bottom_left.x, top_right.y)
      side1 = top_left.gps_distance_to(@bottom_left)
      side2 = top_left.gps_distance_to(@top_right)
      side1*side2
    end

    def bounding_query
      query = 
      %{
          ST_MakePolygon(
            ST_GeomFromText(
              'LINESTRING(#{bottom_left.x} #{bottom_left.y},#{bottom_left.x} #{top_right.y},#{top_right.x} #{top_right.y},#{top_right.x} #{bottom_left.y},#{bottom_left.x} #{bottom_left.y})',
              4326
              ))}
      query
    end
  end

end