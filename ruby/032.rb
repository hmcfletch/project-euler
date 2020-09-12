# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n
# exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
# multiplier, and product is 1 through 9 pandigital.

# Find the sum of all products whose multiplicand/multiplier/product identity can be written as
# a 1 through 9 pandigital.

# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

# require './helpers/integer.rb'
require 'set'

DIGITS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

# def number(current, remainder, index)
#   return Integer.number_from_digits(current) if index == 0

#   remainder.collect do |i|
#     number(current + [i], remainder.reject { |a| a == i }, index - 1)
#   end.flatten
# end

# possibles = {}
# DIGITS.length.times do |i|
#   possibles[i+1] = number([], DIGITS, i+1)
# end

# possibles.each_pair do |k,v|
#   puts "#{k}: #{v.length}"
# end

# puts (possibles[8] - possibles[9]).length

MULTS = [
  [1, 2, 6],
  [1, 3, 5],
  [1, 4, 4],
  [2, 2, 5],
  [2, 3, 4],
  [3, 3, 3]
].freeze

products = Set.new

DIGITS.permutation.to_a.each do |perm|
  MULTS.each do |mult|
    # puts mult.inspect
    i, j, _k = mult

    multiplicand = perm[0..(i - 1)].join.to_i
    multiplier = perm[i..(i + j - 1)].join.to_i
    product = perm[(i + j)..8].join.to_i
    # puts "#{multiplicand} * #{multiplier} = #{product}"

    products.add(product) if multiplicand * multiplier == product
  end
end

puts products.length
puts products.to_a.sum
