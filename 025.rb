# The Fibonacci sequence is defined by the recurrence relation:
#
# F_n = F_n−1 + F_n−2, where F_1 = 1 and F_2 = 1.
# Hence the first 12 terms will be:
#
# F_1 = 1
# F_2 = 1
# F_3 = 2
# F_4 = 3
# F_5 = 5
# F_6 = 8
# F_7 = 13
# F_8 = 21
# F_9 = 34
# F_10 = 55
# F_11 = 89
# F_12 = 144
#
# The 12th term, F12, is the first term to contain three digits.
#
# What is the first term in the Fibonacci sequence to contain 1000 digits?

class Integer

  def num_digits
    raise "Only works with whole numbers" unless self == self.floor

    return 1 if self == 0

    i = self < 0 ? self * -1 : self
    begin
      Math.log10(i).floor + 1
    rescue
      self.num_digits_2(min_digits: 250, max_digits: 1000)
    end
  end

  def num_digits_2(min_digits: 1, max_digits: 100)
    num = nil

    num = (min_digits..max_digits).bsearch { |i| 10 ** i > self }
    num = self.num_digits_2(min_digits: max_digits, max_digits: (max_digits * 2)) if num.nil?

    num
  end

end

fib_1 = 1
fib_2 = 2

count = 3

THRESH = 1000

while fib_2.num_digits < THRESH
  new_fib = fib_1 + fib_2
  fib_1 = fib_2
  fib_2 = new_fib
  count += 1
  puts "#{count} => #{fib_2.num_digits}"
end

# num = 123456789012345678901234.num_digits_2(min_digits: 1, max_digits: 7)
puts "+++ #{count}"
