module Statistics
  class NearestNeighbourIndex
    attr_reader :context
    attr_reader :points, :points_by_id, :kd

    def initialize(context)    
      @context = context
      formated_points = format_points(context.data)
      @points = formated_points[:points]
      @points_by_id = formated_points[:points_by_id]
      kdtree_points = formated_points[:kdtree_points]
      @kd = Kdtree.new(kdtree_points)
    end

    def compute 
      nni_by_radius = 
      distances_by_radius = {}
      points.each do |p|
        nearest_distances = nearest_distances_by_radius(p)
        distances_by_radius.merge!(nearest_distances) {|k, old_v, new_v| old_v + new_v}
      end 
      distances_by_radius.each do |radius, sum_distance|
        nni_by_radius[radius] = nni(sum_distance)
      end
      nni_by_radius
    end

    protected

    def nni(sum_distance)
      area = context.area
      n = points.size
      avg_distance = sum_distance/n
      2*avg_distance*Math::sqrt(n/area)
    end

    def nearest_distances_by_radius(p)
      distances_by_radius = {}
      radius_values.each do |r|
        radius = context.canvas_length_to_meter(r)
        p_canvas = context.gps_to_canvas(p)
        nearest_p = nearest_point(p_canvas)
        dist = distance(p, nearest_p, radius)
        #binding.pry
        distances_by_radius[r] = (dist >= 0 ? dist : 0)
      end
      distances_by_radius
    end

    def radius_values
      [0, 0.5, 1, 1.5, 2, 2.5, 3]
    end

    def nearest_point(p)
      id = kd.nearestk(p.x, p.y, 2)[1]
      points_by_id[id]
    end

    def radius_to_meter(r)
      context.canvas_length_to_meter(r)  
    end

    def distance(gps_p1,gps_p2, radius)
      mercator_p1 = gps_p1.to_mercator
      circle1 = Geometry::Circle.new(mercator_p1, radius)
      mercator_p2 = gps_p2.to_mercator
      circle2 = Geometry::Circle.new(mercator_p2, radius)
      circle1.distance_to(circle2)
    end

    def format_points(original_points)
      points = []
      kdtree_points = []
      points_by_id = {}
      original_points.each do |tuple|
        p = tuple[:point]
        canvas_p = context.gps_to_canvas(p)
        id = tuple[:id]
        points_by_id[id] = p
        kdtree_points << [canvas_p.x, canvas_p.y, id]
        points << p
      end
      {points: points, points_by_id: points_by_id, kdtree_points: kdtree_points}
    end
  end
end