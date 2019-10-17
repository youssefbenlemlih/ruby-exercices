# Author:: Jonas Krukenberg
# Author:: Youssef Benlemlih
class NumberMethods
  # 1.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def sum(numbers)
    result = 0
    numbers.each do |n|
      result += n
    end
    result
  end

  # 2.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def product(numbers)
    result = 1
    numbers.each { |n| result *= n }
    result
  end

  # 3.1
  # the method expects an integer as a number
  # returns current index and start value
  def collatz(start)
    if start > 0
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
  def approx_pi(precision)
    pi_4 = 0
    curr_precision = -1
    k = 0
    until curr_precision == precision
      pi_4_before = pi_4
      add_num = ((-1.0) ** k) / (2.0 * k + 1.0)
      pi_4 += add_num
      curr_precision += 1 if (pi_4 * 4).truncate(curr_precision + 1) == (pi_4_before * 4).truncate(curr_precision + 1)
      # puts sprintf("%d: %.10f\tPräzision: %d\tAbweichung: %+.5f pi:#{result} pi_bf:#{pi_4_before*4}", k, pi_4 * 4, curr_precision, pi_4 * 4 - Math::PI)
      k += 1
    end
    (pi_4 * 4).truncate(precision)
  end

  # 3.3
  def approx_1(precision)
    if precision < 1 && precision > 0
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