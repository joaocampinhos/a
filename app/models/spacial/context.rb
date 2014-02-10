module Spacial

  class Context
    delegate :area, to: :box, prefix: true

    attr_accessor :box, :canvas
    
    def initialize(box, canvas)
      @box = box
      @canvas = canvas
    end
  end

end
