# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
class ChristmasTree
  # @param [Integer] n
  def initialize(n)
    raise ArgumentError, 'n needs to be an Integer!' unless n.is_a?(Numeric) && n.integer?

    @n = n
  end

  # print the christmas tree pattern well formatted to the console
  def draw_tree
    result = ''
    max_cols = @n + 1
    calc_tree.each do |row|
      print = ' ' * ((max_cols - row.length) / 2) * max_cols
      print << row.join(' ')
      result << "#{print}\n"
    end
    puts result
  end

  # generate a multidimensional array
  # 1st layer: rows
  # 2nd layer: elements
  # @return [Array]
  def calc_tree
    tree = []
    n = 1
    while n <= @n
      result = []
      result = [[0, 1]] if n == 1
      tree.each do |row|
        line1 = []
        line2 = []
        row.each_with_index do |elem, i|
          line1 << "#{elem}0" if i.positive?
          line2 << "#{elem}0" if i.zero?
          line2 << "#{elem}1"
        end
        result << line1 unless row.count == 1
        result << line2
      end
      tree = result
      n += 1
    end
    tree
  end
end
