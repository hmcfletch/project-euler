# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284.
# The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.

class Integer
  def proper_divisors
    sqrt = Math.sqrt(self).floor

    ds = []
    (1..sqrt).each do |i|
      if self % i == 0
        ds << i
        ds << (self / i)
      end
    end

    ds.uniq.sort.reject { |i| i == self }
  end

  def sum_of_proper_divisors
    proper_divisors.inject(0, :+)
  end

  def amicable?(n)
    s_sum = sum_of_proper_divisors
    n_sum = n.sum_of_proper_divisors
    self == n_sum && s_sum == n
  end
end

puts "======"
puts 220.amicable?(284)
puts "======"

pds = (1..10_000).collect(&:proper_divisors)

total = 0

pds.each_with_index do |pd, i|
  sum = pd.sum
  n = i + 1
  # puts '+++++++++++'
  # puts "  #{n} => #{pd.inspect} => #{sum}"
  next if n == sum || sum == 0 || pds[sum-1].nil?
  b = pds[sum-1]
  b_sum = b.sum
  # puts "  #{sum} => #{b.inspect} => #{b_sum}"
  # str = "**************" if n == b_sum
  # puts "  #{n} <=> #{b_sum} #{str}"
  total += n if n == b_sum
end

puts "*** #{total} ***"

# a = {}

# (1..100).each do |i|
#   sum = i.sum_of_proper_divisors

#   a[sum] = [] if a[sum].nil?

#   b = a[sum]
#   a[sum] = b.push(i)
# end

# puts a.inspect

# puts "======================="

# puts a.reject { |k, v| v.length == 1 }.inspect

# a.reject { |k, v| v.length == 1 }.values.flatten.inject(0, :+)

# puts a.values.flatten.inject(0, :+)

# puts
