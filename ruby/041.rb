# We shall say that an n-digit number is pandigital if it makes
# use of all the digits 1 to n exactly once. For example,
# 2143 is a 4-digit pandigital and is also prime.
#
# What is the largest n-digit pandigital prime that exists?

require_relative './helpers/prime_helper.rb'

pandigitals = []

(2..9).each do |n|
  digits = (1..n).collect { |a| a }
  pandigitals.concat(digits.permutation.to_a.collect { |perm| perm.join.to_i })
end

ph = PrimeHelper.new

largest = 0

pandigitals.each do |pd|
  largest = pd if pd > largest && ph.prime?(pd)
end

puts largest
