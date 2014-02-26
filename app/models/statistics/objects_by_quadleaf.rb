module Statistics
  class ObjectsByQuadleaf
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
      objects_by_leaf = {}
      trees.each do |radius, tree|
        objects = []
        tree.each_leaf do |leaf|
          objects << leaf.nr_objects
        end
        grouped_distribution = break_distribution(objects.sort)
        objects_by_leaf[radius] = grouped_distribution.reverse
      end
      {name: 'Objects by Quadtree Leaf', stats: objects_by_leaf, type: 'distribution'}
    end

    def radius_values
      [0, 1, 2, 3]
    end

    def break_distribution(distribution)
      breaks = Spacial::Jenks.calculate(distribution, 20)
      breaks.unshift(0)
      groups = []
      breaks.each_cons(2) do |brk1, brk2|
        group = distribution[brk1..brk2]
        groups << group.reduce(:+)/group.size
      end
      groups
    end

    def format_data(data)
      data.map do |tuple|
        gps_p = tuple[:point]
        context.gps_to_canvas(gps_p)
      end
    end
  end
end