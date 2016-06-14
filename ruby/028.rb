# Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13

# diagonals :
# 21, 7, 1, 3, 13
# 17, 5, 1, 9, 25

# It can be verified that the sum of the numbers on the diagonals is 101.
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

max_dimen = 1001

sum = 0

def corner_elements(start, dimen)
  corners = [ start + (dimen - 1) - 1 ]
  3.times { |i| corners << corners[i] + (dimen - 1) }
  corners
end

nums = [ 1 ]
dimen = 1
while dimen < max_dimen do
  dimen += 2
  corners = corner_elements(nums.last + 1, dimen)
  # puts "#{dimen} :: #{corners.inspect}"
  nums += corners
end

# puts nums.inspect

num = nums.inject(0) { |memo, i| memo += i }

puts num
