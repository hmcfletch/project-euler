# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
#
# What is the 10 001st prime number?

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

def prime(n)
  primes = []

  i = 2
  while primes.length < n
    primes << i unless i.factorable_by?(primes)
    i += 1
  end

  primes.last
end

p = prime(10001)

puts p
