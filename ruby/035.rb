# The number, 197, is called a circular prime because all rotations
# of the digits: 197, 971, and 719, are themselves prime.

# There are thirteen such primes below
# 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

# How many circular primes are there below one million?

require './helpers/integer_helper'
require './helpers/prime_helper'
require 'set'

NO_SET = Set.new([ 0, 2, 4, 5, 6, 8 ])

def is_circular_prime?(ph, n)
  digits = IntegerHelper.digits(n)

  len = digits.length

  if len == 1
    ph.is_prime?(n)
  else
    # if any of these digits are present (and it's not 2 or 5),
    # at least one of numbers will not be prime
    return false unless (NO_SET & (digits)).empty?

    nums = []
    (1..len).each do |i|
      x = digits.shift
      digits.push(x)
      nums << IntegerHelper.number_from_digits(digits)
    end

    nums.sort.all? { |p| ph.is_prime?(p) }
  end
end

ph = PrimeHelper.new

cp = []

(1..1000000).each do |p|
  cp << p if is_circular_prime?(ph, p)
end

puts cp.length
