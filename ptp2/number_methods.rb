# Author:: Jonas Krukenberg
class NumberMethods
  # 1.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def sum(numbers = [])
    result = 0
    numbers.each do |n|
      result += n.to_i
    end
    result
  end

  # 2.
  # expects an array with numbers
  # returns the product of all numbers within the input array
  def product(numbers = [])
    result = 1
    numbers.each do |n|
      result = result * n.to_i
    end
    result
  end

  # 3.1
  # the method expects an integer as a number
  # returns current index and start value
  def collatz(number)
    if number > 0
      index = 0
      while number != 1
        index += 1
        if number % 2 == 0
          number = number / 2
        else
          number = 3 * number + 1
        end
        # puts number
      end
      {'start' => number, 'index' => index}
    end
  end

  # 3.2
  def approximation_pi(precision)
    k = 0
    temp = 0.0
    numbers = []
    for k in 1..precision
      number = ((-1.0) ** k) / (2.0 * k + 1.0)
      next_number = ((-1.0) ** (k + 1.0) / (2.0 * (k + 1.0) + 1.0))
      numbers << ((number + next_number) / 2.0)
      k += 1
      puts number
    end

    puts numbers.to_s
  end
end