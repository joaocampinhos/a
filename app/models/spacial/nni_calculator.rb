module Spacial

  class NNICalculator
    @@id_generator = 1

    def initialize(points, context)
      @context = context
      @data = {}
      tree_points = points.map do |point|
        @@id_generator += 1
        new_id = @@id_generator+1
        @data[new_id] = point
        [point.x, point.y, new_id]
      end
      @tree = Kdtree.new(tree_points)
      compute
    end
    
    def nni(radius = 0)
      @nni
    end    


private 

    def compute
      @distances = []
      @data.each do |id, point|
        nearest_point = get_nearest_point(id, point)
        distance = point.gps_distance_to(nearest_point)
        @distances << distance
      end
      n = @data.size
      area =@context.box_area
      avg_distances = (@distances.reduce(0) {|memo, distance| memo+distance})/n
      @nni = 2*avg_distances*Math::sqrt(n/area)
    end

    def get_nearest_point(id, point)
      nearest_points_ids = @tree.nearestk(point.x, point.y, 2)
      if(nearest_points_ids[0] == id)
        id = nearest_points_ids[1]
      else
        id = nearest_points_ids[0]
      end
      @data[id]
    end

  end
end