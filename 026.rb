# A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions
# with denominators 2 to 10 are given:
#
# 1/2 =   0.5
# 1/3 =   0.(3)
# 1/4 =   0.25
# 1/5 =   0.2
# 1/6 =   0.1(6)
# 1/7 =   0.(142857)
# 1/8 =   0.125
# 1/9 =   0.(1)
# 1/10  =   0.1
#
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7
# has a 6-digit recurring cycle.
#
# Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal
# fraction part.

class Integer

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

  def num_digits_2(min_digits: 1, max_digits: 100)
    raise "Only works with whole numbers" unless self == self.floor
    num = nil

    v = self < 0 ? self * -1 : self

    num = (min_digits..max_digits).bsearch { |i| 10 ** i > v }
    num = v.num_digits_2(min_digits: max_digits, max_digits: (max_digits * 2)) if num.nil?

    num
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

  def digits_2
    num_whole_digits = self.floor.num_digits

    v = self < 0 ? self * -1 : self

    ds = []

    i = num_whole_digits - 1
    while v != 0
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

class Numeric

  def digits
    num_whole_digits = self.floor.num_digits

    puts "num_whole_digits: #{num_whole_digits}"

    v = self < 0 ? self * -1 : self

    i = -1
    while v != v.floor && i > -10
      puts v
      v *= 10
      i += 1
    end

    v.floor.digits
  end

end

# [ 643.1234 ].each do |i|
#   puts "#{i} => #{i.digits.inspect}"
# end

# a / b out to num_places
def long_division(a, b, num_places=10)
  raise "only works for integers" if a != a.floor || b != b.floor

  digits = a.digits

  answer = []
  v = [ digits[0] ]

  (1..num_places).each do |i|
    if v[i - 1] % b == 0
      answer << v[i - 1] / b
      return answer
    elsif v[i - 1] < b
      answer << 0
      next_digit = digits.length > i ? digits[i] : 0
      v << v[i - 1] * 10 + next_digit
    else
      c = v[i - 1] / b
      answer << c
      next_digit = digits.length > i ? digits[i] : 0
      v << (v[i-1] - (c * b)) * 10 + next_digit
    end
  end

  answer
end

(2..10).each do |i|
  a = long_division(1, i, 4)
  a.shift
  a.unshift("0.")
  puts a.join
end
