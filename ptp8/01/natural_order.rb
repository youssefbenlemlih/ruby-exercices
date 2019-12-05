# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# This class defines objects of the type m*2^n, m uneven
# objects of this class can be used in ranges
class NaturalOrder
  include Comparable
  attr_reader :value
  # @param [Integer] n exponent of 2
  # @param [Integer] k position in order of uneven natural numbers
  def initialize(n, k = 1)
    @n = n
    @m = 2 * k - 1
    @k = k
    @value = @m * 2 ** @n
  end

  # define the following object of self (for use in ranges)
  def succ
    NaturalOrder.new(@n, @k + 1)
  end

  # define criteria for <=>
  def <=>(other)
    value <=> other.value
  end

  # this method uses binary operations to calculate params for the parent
  # @return [NaturalOrder] parent object of self
  def parent
    j = @value
    j = (j - (j & -j)) | ((j & -j) << 1)
    n = @n + 1
    # j = m * 2**n <=>
    m = j / (2 ** n)
    # m = 2 * k - 1 <=> k = (m + 1) / 2 [m uneven => (m + 1) / 2 is int]
    k = (m + 1) / 2
    NaturalOrder.new(n, k)
  end

  # this method uses binary operations to calculate params for children
  # @return [Array] contains two children NaturalOrder objects
  def children
    childs = []
    return childs if @n.zero?

    j = @value
    childs << j - ((j & -j) >> 1)
    childs << j + ((j & -j) >> 1)
    childs.map do |j|
      n = @n - 1
      # j = m * 2**(n-1) <=>
      m = j / (2 ** n)
      # m = 2 * k - 1 <=> k = (m + 1) / 2 [m uneven => (m + 1) / 2 is int]
      k = (m + 1) / 2
      NaturalOrder.new(n, k)
    end
  end

  # this method may be recursive if there are children of children
  # @return [Array] all children of self
  def children_all
    children.map do |child|
      [child, child.children_all]
    end.flatten
  end

  # fast calculation of parent params without binary operations
  # @return [NaturalOrder] parent object
  def parent_fast
    n = @n + 1
    k = (@k + 1) / 2
    NaturalOrder.new(n, k)
  end

  # fast calculation of children params without binary operations
  # @return [Array] contains children NaturalOrder objects
  def children_fast
    childs = []
    return childs if @n == 0

    childs << NaturalOrder.new(@n - 1, @k * 2 - 1)
    childs << NaturalOrder.new(@n - 1, @k * 2)
  end

  def ==(other)
    return true if equal?(other)
    return false unless other.is_a?(self.clas)

    @value == other.value
  end

  alias_method :eql?, :==

  def hash
    @value.hash
  end

  def to_s
    "value=#{@value}, (m,n)=#{@m},#{@n}"
  end
end