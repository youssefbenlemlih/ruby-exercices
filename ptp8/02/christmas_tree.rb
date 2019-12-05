# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
class ChristmasTree
  def initialize(n)
    @n = n
  end

  def draw_tree
    result = ''
    max_cols = @n + 1
    calc_tree.each do |row|
      print = ' ' * ((max_cols - row.length) / 2)
      print *= (@n + 1)
      print << row.join(' ')
      result << "#{print}\n"
    end
    puts result
  end

  def calc_tree
    tree = []
    n = 1
    while n <= @n
      result = []
      if n == 1
        result = [%w[0 1]]
      else
        tree.each do |row|
          line1 = []
          line2 = []
          r = row.count
          row.each_with_index { |elem, i|
            line1 << "#{elem}0" if i > 0
            line2 << "#{elem}0" if i == 0
            line2 << "#{elem}1"
          }
          result << line1 unless r == 1
          result << line2
        end
      end
      tree = result
      n += 1
    end
    tree
  end
end
