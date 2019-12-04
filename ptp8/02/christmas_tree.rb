class ChristmasTree
  def initialize(n)
    @n = n
  end

  def columns
    @n + 1
  end

  def lines()
    n = @n
    k = n / 2
    (faculty(n)) / (faculty(n - k) * faculty(k))
  end

  def draw_tree
    result = ''
    max_cols = @n + 1
    calc_tree.each do |row|
      print = " " * ((max_cols - row.length) / 2)
      print *= (@n+1)
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
        result = [%w(0 1)]
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

  # Function to calculate the faculty of an Integer
  def faculty(i)
    result = 1
    i.times do |index|
      result *= (index + 1)
    end
    result
  end
end
t = ChristmasTree.new(6)
t.draw_tree