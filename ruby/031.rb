# In England the currency is made up of pound, £, and pence, p, and there are eight coins
# in general circulation:

# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:

# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

VALUES = [ 1, 2, 5, 10, 20, 50, 100, 200 ].reverse
num_ways = {
  1 => 1
}
ways = {
  1 => [ [ 1 ] ]
}

# values is expected to be reverse sorted
def coins(amount, start_value: nil, max_counts: {})
  puts "++++ coins(#{amount}, start_value: #{start_value}, max_counts: #{max_counts.inspect}) ++++"
  ret = {}

  return ret if amount == 0

  VALUES.each_with_index do |a, i|
    next if !start_value.nil? && a > start_value

    # number of coins of the is denomination
    num = amount / a

    num = max_counts[a] if max_counts.has_key?(a) && max_counts[a] < num

    # left over
    remainder = amount - (num * a)

    puts "== #{amount} : #{a} : #{num} : #{remainder}"
    if num > 0
      ret[a] = num
      ret.merge!(coins(remainder, start_value: VALUES[i+1], max_counts: max_counts))
      break
    end
  end

  ret
end

ways = []

ways << coins(200)

5.times do |i|
  w = ways.last

end

ways.each do |a|
  puts a.inspect
end

# vr = values.reverse
# max = 10
# ws = []

# vr.each do |a|
#   # number of coins of the is denomination
#   num = max / a

#   # left over
#   remainder = max % a

#   if num > 0

#   end
# end


# 1 = [ [ 1 ] ]
# 2 = [ [ 2 ], [ 1, 1 ] ]
# 5 = [ [ 5 ], [ 2, 2, 1 ], [ 2, 1, 1, 1 ], [ 1, 1, 1, 1, 1 ] ]
# 10 = [ [ 10 ], [ 5, 5 ], [ 5, 2, 2, 1 ], [ 5, 2, 1, 1, 1 ], [ 5, 1, 1, 1, 1, 1 ], ... ]

# 20
# 10, 10
# 10, 5, 5
# 5, 5, 5, 5
# 10
# 5, 5
# 5, 2, 2, 1
# 5, 2, 1, 1, 1
# 5, 1, 1, 1, 1, 1
# 2, 2, 1, 1, 1, 1, 1, 1
# 2, 1, 1, 1, 1, 1, 1, 1, 1
# 1, 1, 1, 1, 1, 1, 1, 1, 1, 1



# h1 = {}

# values.each { |a| h1[a] = 200 / a }


# hash = {
#   2 => [ 1, 1 ],
#   5 => [ 2, 1, 1 ],
#   10 => [ 5, 5 ],
#   # 20 => [ 10, 10 ],
#   # 50 => [ 20, 20, 10 ],
#   # 100 => [ 50, 50 ],
#   # 200 => [ 100, 100 ],
# }

# def combos(num)
#   c = []
#   val = 2 ** num
#   (0...val).each do |i|
#     k = val - 1 - i
#     a = Array.new(num)
#     for j in (0...num)
#       a[j] = k[num - 1 - j] == 1
#     end
#     c << a
#   end
#   c
# end

# puts combos(3)

# hash.each_pair do |k, v|
#   w = []

#   w << [ k ]
#   w << v.sort

#   len = v.length

#   a = []

#   combos(len).each do |c|
#     v.each_with_index.collect do |a,i|
#       # c[i] ? ways
#       puts "=== #{c.inspect} :: #{a} :: #{i}"
#     end
#   end

#   ways[k] = w
# end

# puts num_ways.inspect
