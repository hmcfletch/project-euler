# A number chain is created by continuously adding the square of the digits
# in a number to form a new number until it has been seen before.

# For example,

# 44 → 32 → 13 → 10 → 1 → 1
# 85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

# Therefore any chain that arrives at 1 or 89 will become stuck in an endless
# loop. What is most amazing is that EVERY starting number will eventually
# arrive at 1 or 89.

# How many starting numbers below ten million will arrive at 89?

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
end

def number_chain(n)
  return [n] if n == 1 || n == 89

  chain = [n]

  while !(chain.last == 1 || chain.last == 89) do
    chain << chain.last.digits.inject(0) { |memo, i| memo = memo + (i * i) }
  end

  chain
end

tally = 0

(1..9999999).each do |i|
  puts i if i % 10000 == 0
  chain = number_chain(i)
  tally += 1 if chain.last == 89
end

puts tally
