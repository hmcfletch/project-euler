class Factors
  class << self
    def prime_factors2(n)
      sqrt = Math.sqrt(b)
      sqrt_floor = sqrt.floor

      factors = []

      (2..sqrt_floor).each do |i|
        next unless (n % i).zero?

        num = n / i
        factors = factors + [i] + num.prime_factors
        break
      end

      factors = [n] if factors.empty?

      factors.sort
    end

    def prime_factors(n)
      primes = []

      max_sqrt = Math.sqrt(n).to_i
      factors = []

      (2..max_sqrt).each do |i|
        if (n % i).zero?
          factors << i
          factors << (n / i)
        end
      end

      factors.sort!

      factors.each do |i|
        primes << i unless i.factorable_by?(factors)
      end

      factors
    end

    def prime_factors_hash(n)
      factors = prime_factors(n)
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

    def factorable_by?(n, factors = [])
      sqrt = Math.sqrt(n)
      factors.each do |i|
        return true if (n % i).zero?
        return false if i > sqrt
      end

      false
    end
  end
end
