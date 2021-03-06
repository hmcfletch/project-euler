# The sequence of triangle numbers is generated by adding the natural numbers.
# So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
#
#  1: 1
#  3: 1,3
#  6: 1,2,3,6
# 10: 1,2,5,10
# 15: 1,3,5,15
# 21: 1,3,7,21
# 28: 1,2,4,7,14,28
# We can see that 28 is the first triangle number to have over five divisors.
#
# What is the value of the first triangle number to have over five hundred divisors?

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

  def triangle_number
    (1..self).inject(0, :+)
  end

end

def run(n)
  i = 1
  while i.triangle_number.divisors.length <= n
    puts i if i % 1000 == 0
    i += 1
  end

  i
end

# puts run(500)

puts 12375.triangle_number.divisors.inspect

# (1..7).each do |i|
#   tn = i.triangle_number
#   puts "#{i} : #{tn} : #{tn.divisors.join(",")}"
# end
