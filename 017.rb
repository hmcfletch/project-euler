# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and
# 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

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

  def self.number_from_digits(digits = [])
    raise "Argument can't be empty" if digits.nil? || digits.empty?

    sum = 0
    digits.each_with_index do |d, i|
      power = digits.length - 1 - i
      sum += d * (10 ** power)
    end

    sum
  end

  WORDS = {
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
    100 => "hundred",
  }

  def to_words
    raise "Not dealing with n > 1000" if self > 1000

    if self <= 19
      WORDS[self]
    else
      ds = self.digits
      if self < 100
        tens = "#{WORDS[ds.first.to_i * 10]}"
        if ds.last != 0
          "#{tens}-#{WORDS[ds.last]}"
        else
          tens
        end
      elsif self < 1000
        hundreds = "#{WORDS[ds.first]} hundred"
        tens_num = self.class.number_from_digits(ds.slice(1,2))
        if tens_num != 0
          "#{hundreds} and #{tens_num.to_words}"
        else
          hundreds
        end
      else # 1000
        "one thousand"
      end
    end
  end

end

puts (1..1000).collect { |i| i.to_words }.join("").gsub("-", "").gsub(" ", "").length
