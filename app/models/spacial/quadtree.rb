module Spacial

  class Quadtree
    MAX_OBJECTS = 2
    MAX_LEVELS = 8

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
      unless leaf?
        distribute(point)
      end
      @objects << point
      if(@objects.size > MAX_OBJECTS)
        split!
        @objects.each do |point|
          distribute(point)
        end
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
          objects.merge(@nodes[index].retrieve(point))
        end
        objects
      end
    end

    def touches?(point)
      @canvas.touches?(point, @radius)
    end

  private 
    def split!
      splited_canvas = @canvas.split
      (0...4).each do |index|
        @nodes[index] = Quadtree.new(splited_canvas[index], @radius, @level+1)
      end  
    end

    def distribute(point)
      (0...4).each do |index|
        if(@nodes[index].touches?(point))
          @nodes[index].insert(point)
        end
      end
    end
  end
end