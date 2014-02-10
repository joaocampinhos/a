module Spacial

  class Point    
    EARTH_RADIUS = 6371

    attr_accessor :x, :y
    alias_method :longitude, :x
    alias_method :latitude, :y

    def initialize(*args)
      if args.size == 1
        coords = args[0]
        @x = coords[:longitude] || coords['longitude'] || coords[:x] || coords['x']
        @y = coords[:latitude] || coords['latitude'] || coords[:y] || coords['y']
      else
        @x = args[0]
        @y = args[1]
      end
    end

    def linear_distance_to(destination)
      Math.sqrt((destination.x - x)**2 + (destination.y - y)**2)
    end

    def gps_distance_to(destination)
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

  end
end
