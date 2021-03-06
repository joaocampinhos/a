module Statistics
  class QuadLeafFrequency
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
      frequency_by_radius = {}
      trees.map do |radius, tree|
        frequency_by_radius[radius] = leaf_frequency(tree)
      end
      max_size = frequency_by_radius.values.reduce(0) {|memo, dist| dist.size > memo ? dist.size : memo}
      {name: 'Quad Leaf Frequency',type: 'frequency', stats: frequency_by_radius }
    end

    def leaf_frequency(tree)
      frequency = Hash.new(0)
      tree.each_leaf do |leaf|
        nr_objects = leaf.nr_objects
        frequency[nr_objects] += 1
      end
      frequency
    end


    protected

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