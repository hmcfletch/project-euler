# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

class Integer

  def factorable_by?(factors = [])
    sqrt = Math.sqrt(self)
    factors.each do |i|
      return true if self % i == 0
      return false if i > sqrt
    end

    false
  end

end

def primes_below(n)
  primes = []

  i = 2
  while i < n
    puts i if i % 100000 == 0
    primes << i unless i.factorable_by?(primes)
    i += 1
  end

  primes
end

primes = primes_below(2000000)
puts primes.inject(0) { |memo, i| memo += i }
