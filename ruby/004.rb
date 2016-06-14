# A palindromic number reads the same both ways. The largest palindrome made from
# the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

MAX_NUM = 999 * 999

class Integer

  def is_palindromic?
    return false if self < 0

    d = digits
    d == d.reverse
  end

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

  def self.number_from_digits(digits = [])
    raise "Argument can't be empty" if digits.nil? || digits.empty?

    sum = 0
    digits.each_with_index do |d, i|
      power = digits.length - 1 - i
      sum += d * (10 ** power)
    end

    sum
  end

end

def max_palindrome
  MAX_NUM.downto(0).each do |i|
    if i.is_palindromic?
      999.downto(100).each do |j|
        if i % j == 0
          v = i / j
          if v >= 100 && v < 1000
            return i
          end
        end
      end
    end
  end
end

puts max_palindrome
