# The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to
# simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

# There are exactly four non-trivial examples of this type of fraction, less than one in value,
# and containing two digits in the numerator and denominator.

# If the product of these four fractions is given in its lowest common terms, find the value of the denominator.

require './helpers/integer.rb'

ns = []
ds = []

(10..99).each do |n|
  (10..99).each do |d|
    next if n >= d

    next if (n % 10).zero? && (d % 10).zero?

    n_digits = n.digits
    d_digits = d.digits

    intersection = n_digits & d_digits

    next if intersection.length != 1

    i = intersection[0]

    n2 =
      if n_digits[0] == i
        n_digits[1]
      else
        n_digits[0]
      end

    d2 =
      if d_digits[0] == i
        d_digits[1]
      else
        d_digits[0]
      end

    next if n2.to_f / d2 != n.to_f / d

    puts "#{n}/#{d}"
    puts "#{n2}/#{d2}"

    ns << n2
    ds << d2
  end
end

puts ns.inspect
puts ds.inspect
puts [1, 1, 2, 4].inject(1) { |memo, i| memo *= i }
puts [4, 5, 5, 8].inject(1) { |memo, i| memo *= i }
