module Geometry

  class GpsPoint
    include Proj4
    MERCATOR_PROJECTION = Projection.new("+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

    EARTH_RADIUS = 6371
  
    delegate :x, :y, :x=, :y= ,:==, :to_rad, to: :point
    attr_accessor :latitude, :longitude

    alias_method :longitude, :x
    alias_method :latitude, :y
    alias_method :longitude=, :x=
    alias_method :latitude=, :y=

    def initialize(*args)
      @point = init_point(args)
    end

    #destination should respond_to latitude and longitude
    def distance_to(destination)
      delta_latitude = (destination.latitude - latitude).to_rad
      delta_longitude = (destination.longitude - longitude).to_rad
      origin_lat_rad = latitude.to_rad
      destination_lat_rad = destination.latitude.to_rad
      a = Math::sin(delta_latitude/2) * Math::sin(delta_latitude/2) + 
        (Math::sin(delta_longitude/2)* 
        Math::sin(delta_longitude/2) * 
        Math::cos(origin_lat_rad) * 
        Math::cos(destination_lat_rad)
        )
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      EARTH_RADIUS * c
    end

    def to_mercator
      MERCATOR_PROJECTION.forward(self.to_rad)
    end

    protected

    attr_reader :point

    def init_point(args)
      if args.size == 2
        build_point(args[0], args[1])
      elsif args.size == 1 && args[0].is_a?(Point) 
        args[0]
      else
        raise 'Wrong Arguments'
      end
    end

    def build_point(x,y)
      Point.new(x,y)
    end

  end
end