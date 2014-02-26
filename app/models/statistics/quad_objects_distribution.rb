module Statistics
  class QuadObjectsDistribution
    attr_reader :context, :trees

    def initialize(context)
      @context = context
      @data = format_data(context.data)
      @canvas = context.canvas
      @trees = radius_values.map do |radius|
        tree = Spacial::Quadtree.new(@canvas, radius)
        @data.each {|p| tree.insert(p)}
        [radius, tree]
      end
    end

    def compute
      objects_distribution = {}
      trees.each do |radius, tree|
        objects = []
        tree.each_leaf do |leaf|
          objects << leaf.nr_objects unless leaf.nr_objects == 0
        end
        objects_distribution[radius] = objects.sort.reverse
      end
      max_size = objects_distribution.values.reduce(0) {|memo, dist| dist.size > memo ? dist.size : memo}
      objects_distribution.keys.each do |key|
        dist = objects_distribution[key]
        objects_distribution[key] = dist.fill(0, dist.size, max_size)
      end
      {name: 'Quad Objects Distribution', type: 'distribution', stats: objects_distribution}
    end

    def radius_values
      [0, 0.5, 1, 1.5, 2, 2.5, 3]
    end

    def format_data(data)
      data.map do |tuple|
        gps_p = tuple[:point]
        context.gps_to_canvas(gps_p)
      end
    end
  end
end