class NaturalOrder
  include Comparable
  attr_reader :value

  def initialize(n, k = 1)
    @n = n
    @m = 2 * k - 1
    @k = k
    @value = @m * 2 ** @n
  end

  def succ
    NaturalOrder.new(@n, @k + 1)
  end

  def <=> (other)
    value <=> other.value
  end

  def parent
    j = @value
    j = (j - (j & -j)) | ((j & -j) << 1)
    n = @n + 1
    m = j / (2 ** n)
    k = (m + 1) / 2
    NaturalOrder.new(n, k)
  end

  def children
    childs = []
    return childs if @n == 0
    j = @value
    childs << j - ((j & -j) >> 1)
    childs << j + ((j & -j) >> 1)
    childs.map do |j|
      n = @n - 1
      m = j / (2 ** n)
      k = (m + 1) / 2
      NaturalOrder.new(n, k)
    end
  end

  def children_all
    children.map do |child|
      [child, child.children_all]
    end.flatten
  end

  def parent_fast
    n = @n + 1
    k = (@k + 1) / 2
    NaturalOrder.new(n, k)
  end

  def children_fast
    childs = []
    return childs if @n == 0
    childs << NaturalOrder.new(@n - 1, @k * 2 - 1)
    childs << NaturalOrder.new(@n - 1, @k * 2)
  end

  def == (other)
    return true if equal?(other)
    return false unless other.is_a?(self.class)
    @value == other.value
  end

  alias_method :eql?, :==

  def to_s
    "value=#{@value}, (m,n)=#{@m},#{@n}"
  end
end