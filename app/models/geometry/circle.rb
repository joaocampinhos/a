module Geometry
  class Circle
    attr_reader :point, :radius
    delegate :x, :y, to: :point

    def initialize(point, radius=0)
      @point = point
      @radius = radius
    end

    def distance_to(circle)
      point.distance_to(circle.point) - (radius + circle.radius)
    end
  end
end