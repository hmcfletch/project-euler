# Take the number 192 and multiply it by each of 1, 2, and 3:

# 192 × 1 = 192
# 192 × 2 = 384
# 192 × 3 = 576
# By concatenating each product we get the 1 to 9 pandigital,
# 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product
# of 9 and (1,2,3,4,5).

# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?

require_relative './helpers/integer_helper.rb'

def concatenated_product(n, i)
  products = [n]
  (2..i).each do |j|
    products << n * j
  end

  products.collect(&:to_s).join
end

MAX_NUM = 100_000

(1..MAX_NUM).each do |n|
  max_mult = (1_000_000_000.0 / n).floor
  break if max_mult == 1

  max_mult = 9 if max_mult > 9

  (1..max_mult).each do |i|
    cp = concatenated_product(n, i)
    next if cp.length > 9
    next unless IntegerHelper.pandigital?(cp.to_i, 1, 9)

    puts "#{n} (#{i}) => #{cp}"
  end
end
