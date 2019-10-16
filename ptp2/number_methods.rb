# Author:: Jonas Krukenberg
class NumberMethods
  # 1.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def sum(numbers)
    result = 0
    numbers.each { |n| result += n.to_i }
    result
  end

  # 2.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def product(numbers)
    result = 1
    numbers.each { |n| result = result * n.to_i }
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
        if number % 2 == 0
          number = number / 2
        else
          number = 3 * number + 1
        end
      end
      {'start' => start, 'index' => index}
    else
      nil
    end
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
      curr_precision += 1 if (pi_4 * 4).truncate(curr_precision+1) == (pi_4_before * 4).truncate(curr_precision+1)
      # puts sprintf("%d: %.10f\tPräzision: %d\tAbweichung: %+.5f pi:#{result} pi_bf:#{pi_4_before*4}", k, pi_4 * 4, curr_precision, pi_4 * 4 - Math::PI)
      k += 1
    end
    (pi_4 * 4).truncate(precision)
  end
end