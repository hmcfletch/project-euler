# The decimal number, 585 = 1001001001_2 (binary), is palindromic in both bases.

# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

# (Please note that the palindromic number, in either base, may not include leading zeros.)

MAX_NUM = 1_000_000

total = 0

(1..(MAX_NUM - 1)).each do |i|
  i_str = i.to_s
  i_str_rev = i_str.reverse
  next if i_str_rev[0] == '0' || i_str != i_str_rev

  b = i.to_s(2)
  b_rev = b.reverse

  next if b_rev[0] == '0' || b != b.reverse

  puts i
  puts "  #{b}"
  total += i
end

puts "+++ #{total}"
