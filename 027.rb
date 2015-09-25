# Euler discovered the remarkable quadratic formula:
#
# n^2 + n + 41
#
# It turns out that the formula will produce 40 primes for the consecutive
# values n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41 is divisible
# by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41.
#
# The incredible formula  n^2 − 79n + 1601 was discovered, which produces 80 primes for
# the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
#
# Considering quadratics of the form:
#
# n^2 + an + b, where |a| < 1000 and |b| < 1000
#
# where |n| is the modulus/absolute value of n
# e.g. |11| = 11 and |−4| = 4
#
# Find the product of the coefficients, a and b, for the quadratic expression that produces
# the maximum number of primes for consecutive values of n, starting with n = 0.

class Integer

  def prime?
    sqrt = Math.sqrt(self)
    sqrt_floor = sqrt.floor

    return false if sqrt == sqrt_floor

    ds = []
    (2..sqrt_floor).each do |i|
      return false if self % i == 0
    end

    true
  end

end

def value(a, b, n)
  v = (n ** 2) + (a * n) + b
  # puts "n^2 + #{a}n + #{b} :: #{n} => #{v}"
  v
end

max_primes = 0
max_a = 0
max_b = 0

(-999..999).each do |a|
  (-999..999).each do |b|
    i = 0
    v = value(a, b, i)
    while v > 0 && v.prime?
      i += 1
      v = value(a, b, i)
    end

    if i > max_primes
      max_a = a
      max_b = b
      max_primes = i
    end
  end
end

puts "n^2 + #{max_a}n + #{max_b}"
puts "product: #{max_a * max_b}"
puts "num_primes: #{max_primes}"
