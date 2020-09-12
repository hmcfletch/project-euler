# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain
# prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
# right to left: 3797, 379, 37, and 3.

# Find the sum of the only eleven primes that are both truncatable from
# left to right and right to left.

# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

require './helpers/integer.rb'
require './helpers/prime_helper.rb'

MAX_NUM = 1_000_000

ph = PrimeHelper.new

a = []

(9..MAX_NUM).each do |i|
  digits = i.digits

  l_digits = digits.dup
  l_digits.shift

  r_digits = digits.dup
  r_digits.pop

  nums = [i]

  until l_digits.empty?
    nums << l_digits.join.to_i
    l_digits.shift
  end

  until r_digits.empty?
    nums << r_digits.join.to_i
    r_digits.pop
  end

  nums.uniq!

  nums_len = nums.length
  nums_len2 = nums.select { |i| ph.is_prime?(i) }.length

  a << i if nums_len == nums_len2
end

puts a.inspect
puts a.length
puts a.sum
