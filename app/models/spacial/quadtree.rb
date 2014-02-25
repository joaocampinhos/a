module Spacial

  class Quadtree
    MAX_OBJECTS = 10
    MAX_LEVELS = 9

    attr_reader :canvas, :nodes, :level, :radius

    def initialize(canvas, radius = 0, level = 0)
      @level = level
      @objects = Set.new
      @canvas = canvas
      @nodes = Array.new(4)
      @radius = radius
    end

    def leaf?
      @nodes[0].nil?
    end

    def insert(point)
      if leaf?
        @objects << point
        if(@objects.size > MAX_OBJECTS && @level <= MAX_LEVELS)
          split!
          @objects.each do |point|
            distribute(point)
          end
        end
      else
        distribute(point)
      end
    end

    def retrieve(point)
      if leaf? && touches?(point)
        @objects
      elsif leaf? && !touches?(point)
        []
      else
        objects = Set.new
        (0...4).each do |index|
          if @nodes[index].touches?(point)
            objects.merge(@nodes[index].retrieve(point))
          end
        end
        objects
      end
    end

    def nr_objects
      @objects.size
    end

    def leaf_stats(memo = 0)
      {}
    end

    def collisions(point)
      objects = retrieve(point)
      objects.select {|p| p.collides?(point) && p != point }
    end

    def touches?(point)
      @canvas.touches?(point, @radius)
    end

    def each_leaf
      if leaf?
        yield self
      else
        @nodes.each do |node|
          node.each_leaf do |leaf|
            yield leaf
          end
        end
      end
    end

  private 
    def split!
      splited_canvas = @canvas.split
      (0...4).each do |index|
        @nodes[index] = Quadtree.new(splited_canvas[index], @radius, @level+1)
      end  
    end

    def distribute(point)
      nr_touches = 0
      (0...4).each do |index|
        if(@nodes[index].touches?(point))
          @nodes[index].insert(point)
          nr_touches +=1
        end
      end
    end

  end
end