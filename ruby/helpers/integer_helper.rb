require_relative './divisors.rb'
require_relative './digits.rb'

class IntegerHelper
  class << self
    def palindromic?(n)
      return false if n < 0

      d = Digits.digits(n)
      d == d.reverse
    end

    def perfect?(n)
      Divisors.proper_divisors(n).inject(0, :+) == n
    end

    def deficient?(n)
      Divisors.proper_divisors(n).inject(0, :+) < n
    end

    def abundant?(n)
      Divisors.proper_divisors(n).inject(0, :+) > n
    end

    def pandigital?(n, start_i, end_i)
      Digits.digits(n).sort == (start_i..end_i).collect{ |a| a }
    end
  end
end
