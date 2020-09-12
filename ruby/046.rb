# It was proposed by Christian Goldbach that every odd composite number can be
# written as the sum of a prime and twice a square.

# 9 = 7 + 2×1^2
# 15 = 7 + 2×2^2
# 21 = 3 + 2×3^2
# 25 = 7 + 2×3^2
# 27 = 19 + 2×2^2
# 33 = 31 + 2×1^2

# It turns out that the conjecture was false.

# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

require './helpers/prime_helper'


def equation(prime, square)
  prime + 2 * square * square
end

def find_equation(ph, n)
  return if n % 2 == 0 # don't care about even numbers
  return if ph.prime?(n) # don't care about prime numbers

  current_idx = 0
  current_square = 1
  current_val =

  while ph[current_idx] < n
    while equation(ph[current_idx], current_square) < n
      current_square += 1
    end

    if equation(ph[current_idx], current_square) == n
      return [ph[current_idx], current_square]
    end

    current_idx += 1
    current_square = 1
  end

  false
end

ph = PrimeHelper.new

n = 33
while find_equation(ph, n) != false do
  n += 1
end

puts n
