# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

# 1634 = 1^4 + 6^4 + 3^4 + 4^4
# 8208 = 8^4 + 2^4 + 0^4 + 8^4
# 9474 = 9^4 + 4^4 + 7^4 + 4^4
# As 1 = 1^4 is not a sum it is not included.

# The sum of these numbers is 1634 + 8208 + 9474 = 19316.

# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

class Integer

  # digits

  def num_digits
    raise "Only works with whole numbers" unless self == self.floor

    return 1 if self == 0

    i = self < 0 ? self * -1 : self
    begin
      # Math.log10(i) throws us Infinity are ~300 digits so we have to try a different way
      Math.log10(i).floor + 1
    rescue
      i.num_digits_2(min_digits: 250, max_digits: 1000)
    end
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

max_number = 1000000
power = 5

nums = []

(2..max_number).each do |i|
  digits = i.digits
  nums << i if i == i.digits.collect { |j| j ** power }.inject(0) { |memo, k| memo += k }
end

puts nums.inspect

puts nums.inject(0) { |memo, i| memo += i }
