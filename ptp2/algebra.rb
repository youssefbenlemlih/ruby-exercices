# Author:: Jonas Krukenberg
# Author:: Youssef Benlemlih
class Algebra
  # 1.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def sum(numbers)
    numbers.inject(0) { |result, num| num.is_a?(Numeric) ? result + num : result }
  end

  # 2.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def product(numbers)
    numbers.inject(1) { |result, num| num.is_a?(Numeric) ? result * num : result }
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
  # expects rational precision (1/10, 1/100, ...)
  # returns pi with the given precision
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
  # expects rational precision < 1 and > 0
  # returns 1 with the given precision
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
  # expects int a and int b as factors for multiplikation
  # returns product of a * b
  def ethiopian_multiplication(a, b)
    if a > b
      # a should be smaller than b
      tmp = a
      a = b
      b = tmp
    end
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