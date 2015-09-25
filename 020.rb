# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

class Integer

  def num_digits
    raise "Only works with whole numbers" unless self == self.floor

    return 1 if self == 0

    i = self < 0 ? self * -1 : self
    Math.log10(i).floor + 1
  end

  def digits
    nd = self.num_digits

    v = self < 0 ? self * -1 : self

    ds = []

    (nd - 1).downto(0).each do |i|
      d = v / (10 ** i)
      v -= d * (10 ** i)
      ds << d
    end

    ds
  end

end

puts (1..100).inject(1, :*).digits.inject(0, :+)
