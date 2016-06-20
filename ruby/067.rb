# By starting at the top of the triangle below and moving to adjacent numbers on
# the row below, the maximum total from top to bottom is 23.

# 3
# 7 4
# 2 4 6
# 8 5 9 3

# That is, 3 + 7 + 4 + 9 = 23.

# Find the maximum total from top to bottom in triangle.txt (right click and
# 'Save Link/Target As...'), a 15K text file containing a triangle with
# one-hundred rows.

# NOTE: This is a much more difficult version of Problem 18. It is not possible
# to try every route to solve this problem, as there are 299 altogether! If you
# could check one trillion (1012) routes every second it would take over twenty
# billion years to check them all. There is an efficient algorithm to solve it.
# ;o)

triangle = []

f = File.open("data_files/p067_triangle.txt", "r") do |f|
  f.each_line do |line|
    triangle << line.split(" ").map{ |j| j.to_i }
  end
end

height = triangle.length
width = triangle[height-1].length

values = Array.new(height)

(1..(triangle.length)).each do |i|
  values[i-1] = Array.new(i)
end

(0..(height-1)).each do |i| # row
  (0..i).each do |j| # column
    if i-1 < 0
      values[i][j] = triangle[i][j]
    elsif j-1 < 0
      values[i][j] = values[i-1][j] + triangle[i][j]
    elsif i == j
      values[i][j] = values[i-1][j-1] + triangle[i][j]
    else
      values[i][j] = [values[i-1][j] + triangle[i][j], values[i-1][j-1] + triangle[i][j]].max
    end
  end
end

puts values[height-1].max
