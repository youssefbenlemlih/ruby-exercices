# Author:: Jonas Krukenberg
# Author:: Youssef Benlemlih
class NumberMethods
  # 1.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def sum(numbers)
    numbers.inject(0) { |result, num| result + num }
  end

  # 2.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def product(numbers)
    numbers.inject(1) { |result, num| result * num }
  end

  # 3.1
  # the method expects an integer as a number
  # returns current index and start value
  def collatz(start)
    if start.positive?
      number = start
      index = 0
      until number == 1
        index += 1
        number = number.even? ? number / 2 : 3 * number + 1
      end
      return { 'start' => start, 'index' => index }
    end
    nil
  end

  # 3.2
  def approx_pi(rational)
    pi_4 = 0
    k = 0
    precision = rational.to_s.count('0')
    begin
      pi_4_before = pi_4
      pi_4 += ((-1.0)**k) / (2.0 * k + 1.0)
      k += 1
    end until (pi_4 * 4).floor(precision) == (pi_4_before * 4).floor(precision)
    (pi_4 * 4).floor(precision)
  end

  # 3.3
  def approx_1(precision)
    if precision < 1 && precision.positive?
      k = 2
      values_r = []
      values_f = []
      loop do
        curr_value = Rational(k - 1, faculty(k))
        values_r << curr_value
        values_f << curr_value.to_f
        break if (1 - sum(values_r)) <= precision

        k += 1
      end
      return { 'values_f' => values_f,
               'values_r' => values_r,
               'sum_f' => sum(values_f).to_f,
               'sum_r' => sum(values_r),
               'index' => k - 2 }
    end
    nil
  end

  # 4.
  def ethiopian_multiplication(a, b)
    sum = 0
    while a >= 1
      sum += b if a.odd?
      a /= 2
      b *= 2
    end
    sum
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