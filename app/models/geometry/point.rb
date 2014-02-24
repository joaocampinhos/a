module Geometry
  class Point

    attr_accessor :x, :y

    def initialize(x,y)
      @x = x
      @y = y
    end

    def ==(o)
      x == o.x && y == o.y
    end

    def to_rad
      Point.new(x.to_rad, y.to_rad)
    end

    def to_degree
      Point.new(x.to_degree, y.to_degree)
    end
    
    #Destination should respond_to x and y
    def distance_to(destination)
      Math::sqrt((x - destination.x)**2 + (y- destination.y)**2)
    end

  end
end