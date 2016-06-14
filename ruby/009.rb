# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#
# a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

def pythagorean_triple?(a, b, c)
  if c < b || c < a || b < a
    false
  elsif a ** 2 + b ** 2 != c ** 2
    false
  else
    true
  end
end

puts pythagorean_triple?(3, 4, 5)

def find
  1000.downto(1) do |c|
    (1000 - c - 1).downto(1) do |b|
      a = 1000 - b - c
      return [a, b, c] if pythagorean_triple?(a, b, c)
    end
  end
end

a, b, c = find

puts a
puts b
puts c

puts "#{a}^2 + #{b}^2 = #{a ** 2} + #{b ** 2} = #{c ** 2} = #{c}^2"
puts "#{a} + #{b} + #{c} = #{a + b + c}"
puts a * b * c
