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
      when 'qbd'
        QuadObjectsDistribution.new(context)
      when 'oqf'
        ObjectsByQuadleaf.new(context)
      end
    end
  end
end