class Integer
  # digits
  def num_digits
    raise ArgumentError, 'Only works with whole numbers' unless self == floor

    return 1 if self.zero?

    i = self < 0 ? self * -1 : self
    begin
      # Math.log10(i) throws us Infinity are ~300 digits so we have to try a different way
      Math.log10(i).floor + 1
    rescue
      i.num_digits_2(min_digits: 250, max_digits: 1000)
    end
  end

  def num_digits_2(min_digits: 1, max_digits: 100)
    raise ArgumentError, 'Only works with whole numbers' unless self == floor

    v = self < 0 ? self * -1 : self

    num = (min_digits..max_digits).bsearch { |i| 10 ** i > v }
    num = v.num_digits_2(min_digits: max_digits, max_digits: (max_digits * 2)) if num.nil?

    num
  end

  def digits
    nd = num_digits

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
    raise ArgumentError, "Argument can't be empty" if digits.nil? || digits.empty?

    sum = 0
    digits.each_with_index do |d, i|
      power = digits.length - 1 - i
      sum += d * (10 ** power)
    end

    sum
  end

  # divisors

  def divisors
    sqrt = Math.sqrt(self).floor

    ds = []
    (1..sqrt).each do |i|
      if (self % i).zero?
        ds << i
        ds << (self / i)
      end
    end

    ds.uniq.sort
  end

  def proper_divisors
    divisors.reject { |i| i == self }
  end

  # factors

  def prime_factors2
    sqrt = Math.sqrt(self)
    sqrt_floor = sqrt.floor

    factors = []

    (2..sqrt_floor).each do |i|
      next unless (self % i).zero?

      num = self / i
      factors = factors + [i] + num.prime_factors
      break
    end

    factors = [ self ] if factors.empty?

    factors.sort
  end

  def prime_factors
    primes = []

    max_sqrt = Math.sqrt(self).to_i
    factors = []

    (2..max_sqrt).each do |i|
      if (self % i).zero?
        factors << i
        factors << (self / i)
      end
    end

    factors.sort!

    factors.each do |i|
      primes << i unless i.factorable_by?(factors)
    end

    factors
  end

  def prime_factors_hash
    factors = prime_factors
    h = {}
    factors.each do |i|
      h[i] =
        if h.key?(i)
          h[i] + 1
        else
          1
        end
    end
    h
  end

  def factorable_by?(factors = [])
    sqrt = Math.sqrt(self)
    factors.each do |i|
      return true if (self % i).zero?
      return false if i > sqrt
    end

    false
  end

  # booleans

  def is_palindromic?
    return false if self < 0

    d = digits
    d == d.reverse
  end

  def perfect?
    proper_divisors.inject(0, :+) == self
  end

  def deficient?
    proper_divisors.inject(0, :+) < self
  end

  def abundant?
    proper_divisors.inject(0, :+) > self
  end

  def prime?
    sqrt = Math.sqrt(self)
    sqrt_floor = sqrt.floor

    return false if sqrt == sqrt_floor

    (2..sqrt_floor).each do |i|
      return false if (self % i).zero?
    end

    true
  end
end
