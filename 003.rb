# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

TO_FACTOR = 13195

MAX_FACTOR = Math.sqrt(TO_FACTOR)

class Integer

  def prime_factors
    primes = []

    max_sqrt = Math.sqrt(self).to_i
    factors = []
    i = 2

    (2..max_sqrt).each do |i|
      if self % i == 0
        factors << i
        factors << (self / i)
      end
    end

    factors.sort!

    factors.each do |i|
      primes << i unless i.factorable_by?(factors.reject { |j| j == i })
    end

    factors
    # primes
  end

  def factorable_by?(factors = [])
    sqrt = Math.sqrt(self)
    factors.each do |i|
      return true if self % i == 0
      return false if i > sqrt
    end

    false
  end

end

pf = 600851475143.prime_factors.sort

puts pf.inspect
puts pf.last
# puts 17.prime_factors.inspect
