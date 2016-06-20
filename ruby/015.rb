# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
# there are exactly 6 routes to the bottom right corner.
#
# https://projecteuler.net/problem=15 for image
#
# How many such routes are there through a 20×20 grid?

# 1x1 => 4

# R D
# D R

# 2x2 => 6

# R R D D
# R D R D
# R D D R
# D R D R
# D R R D
# D D R R

# 3x3 => 20

# RRRDDD
# RRDRDD
# RRDDRD
# RRDDDR
# RDRRDD
# RDRDRD
# RDRDDR
# RDDRRD
# RDDRDR
# RDDDRR
# DRRRDD
# DRRDRD
# DRRDDR
# DRDRRD
# DRDRDR
# DRDDRR
# DDRRRD
# DDRRDR
# DDRDRR
# DDDRRR

# (n+k) choose (k)

# (1x1) => (1+1) choose (1) => 2 choose 1 = 2
# (2x2) => (2+2) choose (2) => 4 choose 2 = 6
# (3x3) => (3+3) choose (3) => 6 choose 3 = 20

# https://en.wikipedia.org/wiki/Binomial_coefficient#Combinatorics_and_statistics
# There are (n+k) choose (k) strings containing k ones and n zeros

# n choose k

# =

#    n!
# ---------
# k! (n-k)!

# 20x20

# (20+20) choose (20) => 40 choose 20

#      40!
# --------------
# 20! (40 - 20)!

def factorial(n)
  (1..n).inject(1) { |memo, i| memo = memo * i }
end

n = 40
k = 20

puts factorial(n) / (factorial(k) * factorial(n - k))
