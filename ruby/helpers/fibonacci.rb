class Fibonacci
  class << self
    def term(n)
      raise ArgumentError, 'n > 0' if n < 1

      if n == 1
        [1]
      elsif n == 2
        [1, 2]
      else
        a = 1
        b = 2
        val = 0

        (3..n).each do |i|
          val = a + b
          a = b
          b = val
        end

        val
      end
    end

    def terms(n)
      raise 'n > 0' if n < 1

      if n == 1
        [1]
      elsif n == 2
        [1, 2]
      else
        nums = [1, 2]

        while nums.length < n
          i = nums.length
          nums << nums[i - 2] + nums[i - 1]
        end

        nums
      end
    end

    def find_term(a: nil)
      raise ArgumentError, 'find_term requires a block' unless block_given?

      fib_1 = 1
      fib_2 = 2

      count = 3

      while yield fib_1, fib_2
        new_fib = fib_1 + fib_2
        fib_1 = fib_2
        fib_2 = new_fib
        a.call(fib_1, fib_2) unless a.nil?
        count += 1
      end

      count
    end

    def find_num(a: nil)
      raise ArgumentError, 'find_term requires a block' unless block_given?

      fib_1 = 1
      fib_2 = 2

      while yield fib_1, fib_2
        new_fib = fib_1 + fib_2
        fib_1 = fib_2
        fib_2 = new_fib
      end

      fib_2
    end
  end
end
