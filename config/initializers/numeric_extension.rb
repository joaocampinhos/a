class Numeric
  def to_rad
    (self * Math::PI)/180
  end

  def to_degree
    (self * 180) / Math::PI
  end
end