module Spacial

  include Proj4
  MERCATOR_PROJECTION = Projection.new("+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

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

    def to_rad
      Point.new(x.to_rad, y.to_rad)
    end

    def to_meter 
      rad_point = self.to_rad
      meter_point = MERCATOR_PROJECTION.forward(rad_point)
      Point.new(meter_point.x, meter_point.y)
    end

    def box_to_canvas(box, canvas)
      bl_meter = box.bottom_left.to_meter
      point_meter = self.to_meter
      x_meter = (point_meter.x - bl_meter.x)
      y_meter = (point_meter.y - bl_meter.y)
      Point.new((x_meter*canvas.width)/box.width_in_meter, (y_meter*canvas.height)/box.height_in_meter)
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

    def collides?(point, radius = 0)
      (linear_distance_to(point) - 2*radius) <= 0
    end

  end
end
