# An irrational decimal fraction is created by concatenating the
# positive integers:
#
# 0.12345678910_1_112131415161718192021...
#
# It can be seen that the 12th digit of the fractional part is 1.
#
# If dn represents the nth digit of the fractional part, find the value of
# the following expression.
#
# d_1 × d_10 × d_100 × d_1000 × d_10000 × d_100000 × d_1000000

MAX_NUM = 200_000

num = (1..MAX_NUM).collect { |i| i.to_s }.join
# puts num.length

tally = 1
[1, 10, 100, 1_000, 10_000, 100_000, 1_000_000].each do |i|
  tally *= num[i - 1].to_i
end

puts tally
