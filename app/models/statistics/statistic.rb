module Statistics
  class Statistic
    def self.build(name, context)
      case name
      when 'nni'
        NearestNeighbourIndex.new(context)
      when 'pcf'
        PixelCollisionFrequency.new(context)
      when 'qlf'
        QuadLeafFrequency.new(context)
      end
    end
  end
end