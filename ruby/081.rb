# In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom
# right, by only moving to the right and down, is indicated in bold red and is
# equal to 2427.

# ⎛ 131 673 234 103  18 ⎞
# ⎜ 201  96 342 965 150 ⎟
# ⎜ 630 803 746 422 111 ⎟
# ⎜ 537 699 497 121 956 ⎟
# ⎝ 805 732 524  37 331 ⎠

# Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."),
# a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right
# by only moving right and down.

matrix = []

f = File.open("data_files/p081_matrix.txt", "r") do |f|
  f.each_line do |line|
    matrix << line.split(",").map{ |j| j.to_i }
  end
end

width = matrix[0].length
height = matrix.length

values = Array.new(height) { Array.new(width) }

(0..(height-1)).each do |i| # row
  (0..(width-1)).each do |j| # column
    if j-1 < 0 && i-1 < 0 # top left corner
      values[i][j] = matrix[i][j]
    elsif i-1 < 0 # top row
      values[i][j] = values[i][j-1] + matrix[i][j]
    elsif j-1 < 0 # left column
      values[i][j] = values[i-1][j] + matrix[i][j]
    else
      values[i][j] = [values[i-1][j] + matrix[i][j], values[i][j-1] + matrix[i][j]].min
    end
  end
end

puts values[height-1][width-1]
