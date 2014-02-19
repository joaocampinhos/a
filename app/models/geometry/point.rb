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
    
    #Destination should respond_to x and y
    def distance_to(destination)
      Math::sqrt((x - destination.x)**2 + (y- destination.y)**2)
    end

  end
end