# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n
# exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
# multiplier, and product is 1 through 9 pandigital.

# Find the sum of all products whose multiplicand/multiplier/product identity can be written as
# a 1 through 9 pandigital.

# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

DIGITS = [ 1, 2, 3, 4, 5, 6, 7, 8, 9]

class Integer

  def self.number_from_digits(digits = [])
    raise "Argument can't be empty" if digits.nil? || digits.empty?

    sum = 0
    digits.each_with_index do |d, i|
      power = digits.length - 1 - i
      sum += d * (10 ** power)
    end

    sum
  end

end

def number(current, remainder, index)
  return Integer.number_from_digits(current) if index == 0

  remainder.collect do |i|
    number(current + [i], remainder.reject { |a| a == i }, index - 1)
  end.flatten
end

possibles = {}
DIGITS.length.times do |i|
  possibles[i+1] = number([], DIGITS, i+1)
end

possibles.each_pair do |k,v|
  puts "#{k}: #{v.length}"
end

puts (possibles[8] - possibles[9]).length
