# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

# Find the sum of all numbers which are equal to the sum of the factorial of their digits.

# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

require './helpers/integer.rb'
require './helpers/combinatorics_helper.rb'

MAX_NUM = 1_000_000

fact_map = Hash[(0..9).collect { |i| [i, CombinatoricsHelper.factorial(i)] }]

puts fact_map.inspect

a = (3..MAX_NUM).select do |i|
  digits = i.digits
  sum = digits.collect { |d| fact_map[d] }.sum

  sum == i
end

puts a.inspect
puts a.sum
