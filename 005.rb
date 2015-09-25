# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?


# The idea here is to collect all of the prime factors of each number from 1 to 20 (i.e., 20 => [ 2, 2, 5 ]).
# Then we need to union the sets.

class Integer

  def prime_factors
    sqrt = Math.sqrt(self)
    sqrt_floor = sqrt.floor

    factors = []

    i = 2
    (2..sqrt_floor).each do |i|
      if self % i == 0
        num = self / i
        factors = factors + [ i ] + num.prime_factors
        break
      end
    end

    factors = [ self ] if factors.empty?

    factors.sort
  end

  def prime_factors_hash
    factors = prime_factors
    h = {}
    factors.each do |i|
      if h.has_key?(i)
        h[i] = h[i] += 1
      else
        h[i] = 1
      end
    end
    h
  end

end

def test(n, i = 10)
  result = true
  (1..i).each do |j|
    remainder = n % j
    result = result && remainder == 0

    puts "#{n} % #{j} = #{remainder}" if remainder != 0
  end

  return result
end

nums = []; 20.times { |i| nums << (i + 1) }

factors = {}

nums.each do |i|
  facts = i.prime_factors_hash
  facts.each_pair do |k,v|
    factors[k] = v if !factors.has_key?(k) || factors[k] < v
  end
end

num = factors.inject(1) { |memo, i| puts i.inspect; memo *= (i[0] ** i[1]) }

puts num
puts test(num, 20)
