module Spacial
  class Jenks
    def self.calculate(data, nr_classes)      
      data_size = data.size
      mat1 = Array.new(data_size+1) { Array.new(nr_classes+1) }
      mat2 = Array.new(data_size+1) { Array.new(nr_classes+1) }
      st = Array.new(data_size)
      (1..nr_classes).each do |i|
        mat1[1][i] = 1
        mat2[1][i] = 0
        (2..data_size).each do |j|
          mat2[j][i] = Float::INFINITY
        end
      end

      v = 0 
      (2..data_size).each do |l|
        s1 = 0
        s2 = 0
        w = 0
        (1..l).each do |m|
          i3 = l-m+1
          val = data[i3-1]
          s2 += val*val
          s1 += val
          w += 1
          v = s2 - (s1*s1)/w
          i4 = i3-1
          unless i4 == 0
            (2..nr_classes).each do |j|
              if mat2[l][j] >= (v+mat2[i4][j-1])
                mat1[l][j] = i3
                mat2[l][j] = v+mat2[i4][j-1]
              end
            end
          end
        end
        mat1[l][1] = 1
        mat2[l][1] = v
      end

      k = data_size
      breaks = Array.new(nr_classes)
      breaks[nr_classes-1] = data_size - 1

      nr_classes.downto(2) do |j|
        puts "Rank = #{mat1[k][j]}"
        id = mat1[k][j] - 2
        puts "Val = #{data[id]}"
        breaks[j-2] = id
        k = mat1[k][j] - 1
      end
      breaks 
    end
  end
end