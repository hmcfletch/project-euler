# The number, 1406357289, is a 0 to 9 pandigital number because it
# is made up of each of the digits 0 to 9 in some order, but it also
# has a rather interesting sub-string divisibility property.
#
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this
# way, we note the following:
#
# d_2d_3d_4=406 is divisible by 2
# d_3d_4d_5=063 is divisible by 3
# d_4d_5d_6=635 is divisible by 5
# d_5d_6d_7=357 is divisible by 7
# d_6d_7d_8=572 is divisible by 11
# d_7d_8d_9=728 is divisible by 13
# d_8d_9d_10=289 is divisible by 17
#
# Find the sum of all 0 to 9 pandigital numbers with this property.

DIGITS = (0..9).collect { |a| a }.freeze
pandigitals = DIGITS.permutation.to_a.collect { |perm| perm.join }

total = 0

pandigitals.each do |pd|
  next unless (pd[1..3].to_i % 2).zero?
  next unless (pd[2..4].to_i % 3).zero?
  next unless (pd[3..5].to_i % 5).zero?
  next unless (pd[4..6].to_i % 7).zero?
  next unless (pd[5..7].to_i % 11).zero?
  next unless (pd[6..8].to_i % 13).zero?
  next unless (pd[7..9].to_i % 17).zero?

  total += pd.to_i
end

puts total
