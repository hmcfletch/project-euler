class Divisors
  class << self
    def divisors(n)
      sqrt = Math.sqrt(n).floor

      ds = []
      (1..sqrt).each do |i|
        if (n % i).zero?
          ds << i
          ds << (n / i)
        end
      end

      ds.uniq.sort
    end

    def proper_divisors(n)
      divisors(n).reject { |i| i == n }
    end
  end
end
