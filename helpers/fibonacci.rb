class Fibonacci

  class << self

    def term(n)

    end

    def terms(n)
      raise "n > 0" if n < 1

      if n == 1
        [ 1 ]
      elsif n == 2
        [ 1, 2 ]
      else
        nums = [ 1, 2 ]
      end

    end

    def find_term(a:nil, &block)
      raise "find_term requires a block" unless block_given?

      fib_1 = 1
      fib_2 = 2

      count = 3

      while (yield fib_1, fib_2)
        new_fib = fib_1 + fib_2
        fib_1 = fib_2
        fib_2 = new_fib
        a.call(fib_1, fib_2) unless a.nil?
        count += 1
      end

      count
    end

    def find_num(a:nil, &block)
      raise "find_term requires a block" unless block_given?

      fib_1 = 1
      fib_2 = 2

      while (yield fib_1, fib_2)
        new_fib = fib_1 + fib_2
        fib_1 = fib_2
        fib_2 = new_fib
      end

      fib_2
    end
  end

end
