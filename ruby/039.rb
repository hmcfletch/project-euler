# If p is the perimeter of a right angle triangle with integral length
# sides, {a,b,c}, there are exactly three solutions for p = 120.
#
# {20,48,52}, {24,45,51}, {30,40,50}
#
# For which value of p ≤ 1000, is the number of solutions maximised?

MAX_NUM = 1000

perimeters = {}

(1..MAX_NUM).each do |a|
  (1..MAX_NUM).each do |b|
    c = Math.sqrt(a ** 2 + b ** 2)

    next if c != c.floor

    c = c.to_i

    perimeter = a + b + c

    next if perimeter > 1000

    perimeters[perimeter] ||= []

    str = "{#{a}, #{b}, #{c}}"
    puts "#{str} => #{perimeter}"
    perimeters[perimeter].push(str)
  end
end

# puts perimeters.inspect
puts perimeters[120].inspect
a = perimeters.sort_by { |a| -a[1].length }
# puts a.inspect
puts a.first[0]
