class IntegerHelper

  class << self

    # digits

    def num_digits(n)
      raise "Only works with whole numbers" unless n == n.floor

      return 1 if n == 0

      i = n < 0 ? n * -1 : n
      begin
        # Math.log10(i) throws us Infinity are ~300 digits so we have to try a different way
        Math.log10(i).floor + 1
      rescue
        num_digits_2(n, min_digits: 250, max_digits: 1000)
      end
    end

    def num_digits_2(n, min_digits: 1, max_digits: 100)
      raise "Only works with whole numbers" unless n == n.floor
      num = nil

      v = n < 0 ? n * -1 : n

      num = (min_digits..max_digits).bsearch { |i| 10 ** i > v }
      num = v.num_digits_2(min_digits: max_digits, max_digits: (max_digits * 2)) if num.nil?

      num
    end

    def digits(n)
      nd = num_digits(n)

      v = n < 0 ? n * -1 : n

      ds = []

      (nd - 1).downto(0).each do |i|
        d = v / (10 ** i)
        v -= d * (10 ** i)
        ds << d
      end

      ds
    end

    def number_from_digits(digits = [])
      raise "Argument can't be empty" if digits.nil? || digits.empty?

      sum = 0
      digits.each_with_index do |d, i|
        power = digits.length - 1 - i
        sum += d * (10 ** power)
      end

      sum
    end

  end

end
