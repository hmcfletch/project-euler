# A perfect number is a number for which the sum of its proper divisors is exactly
# equal to the number. For example, the sum of the proper divisors of 28 would be
# 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#
# A number n is called deficient if the sum of its proper divisors is less than n
# and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number
# that can be written as the sum of two abundant numbers is 24. By mathematical
# analysis, it can be shown that all integers greater than 28123 can be written as
# the sum of two abundant numbers. However, this upper limit cannot be reduced any
# further by analysis even though it is known that the greatest number that cannot be
# expressed as the sum of two abundant numbers is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

require 'set'

class Integer

  def divisors
    sqrt = Math.sqrt(self).floor

    ds = []
    (1..sqrt).each do |i|
      if self % i == 0
        ds << i
        ds << (self / i)
      end
    end

    ds.uniq.sort
  end

  def proper_divisors
    divisors.reject { |i| i == self }
  end

  def perfect?
    proper_divisors.inject(0, :+) == self
  end

  def deficient?
    proper_divisors.inject(0, :+) < self
  end

  def abundant?
    proper_divisors.inject(0, :+) > self
  end

end

MAX = 28123

abundant_array = (1..MAX).select { |i| i.abundant? }
abundant_set = Set.new(abundant_array)

puts abundant_array.length

sum = 0

(1..MAX).each do |i|
  can_express = false

  abundant_array.each do |j|
    break if j >= i

    r = i - j

    if abundant_set.include?(r)
      can_express = true
      break
    end
  end

  unless can_express
    sum += i
  end
end

puts sum
