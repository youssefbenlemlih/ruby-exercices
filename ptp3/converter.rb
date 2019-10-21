class Converter
  def initialize
    @factors = {
        "m" => {
            "km" => 1000,
            "in" => 0.0254,
            "ft" => 0.3048,
            "yd" => 0.9144,
            "mile" => 1609.34,
            "potrzebie" => 0.002263,
            "m" => 1,
            "cm" => 0.01,
            "mm" => 0.001,
        },
        "g"=>{
            "g"=>1,
            "kg"=>1000,
            "t"=>1000000
        }
    }
  end

  def convert (num, u1, u2)
    b1 =base_unit(u1)
    b2 =base_unit(u2)
    if b1 && b2 && b1 == b2
      num * @factors[b1][u1] / @factors[b2][u2]
    else
      nil
    end
  end

  def list_units
    units = []
    @factors.each_value do |v|
      v.each_key { |k| units << k }
    end
    units
  end

  def base_unit(u)
    @factors.each do |k,v|
      if v.keys.include?(u)
        return k
      end
    end
    nil
  end

end