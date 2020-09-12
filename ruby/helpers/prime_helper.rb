class PrimeHelper
  attr_reader :primes_lookup, :max_checked

  def initialize
    @primes = []
    @primes_lookup = {}
    add(2)

    @max_checked = 2
  end

  #

  def cached_primes
    @primes
  end

  #

  def [](idx)
    first!(idx + 1)

    @primes[idx]
  end

  #

  # return the first n primes
  # will iterate over the first n primes if a block is given
  def first(n)
    first!(n)

    if block_given?
      i = 0
      @primes.each do |p|
        break if i >= n

        yield p
        i += 1
      end
      true
    else
      @primes.first(n)
    end
  end

  # generate the first n primes
  def first!(n)
    next! while @primes.length < n

    true
  end

  #

  # return primes less or equal to n
  # will iterate over the primes less than or equal to n if a block is given
  def max(n)
    max!(n)

    if block_given?
      @primes.each do |p|
        break if p > n

        yield p
      end
    else
      # find the index of the prime less than or equal to n
      idx =
        if @primes.respond_to?(:bsearch_index)
          @primes.bsearch_index { |p| p <= n }
        else
          @primes.find_index { |p| p >= n }
        end

      # if idx is nil then we return the whole thing
      if idx.nil?
        @primes
      else
        idx += 1 if @primes[idx] == n

        @primes.first(idx)
      end
    end
  end

  # generate primes less or equal to n
  def max!(n)
    # we only need to do something if n is greater than
    # the largest number we have checked
    if n > @max_checked
      # start at the largest number we have checked
      ((@max_checked+1)..n).each do |i|
        add_prime(i) if prime?(i)
      end
      @max_checked = n
    end

    true
  end

  #

  # return the next prime
  def next
    next!
    @primes.last
  end

  # generate the next prime
  def next!
    i = @max_checked
    current_max = @primes.last
    while current_max == @primes.last
      i += 1
      add(i) if prime?(i)
    end
    @max_checked = @primes.last

    true
  end

  #

  # check if n is prime
  def prime?(n)
    if n <= @primes.last
      # we have already have a prime greater than n,
      # check if this is in our set
      return @primes_lookup.has_key?(n)
      # return !@primes.bsearch { |p| n <=> p }.nil?
    elsif n < @max_checked
      # n is greater than our largest prime,
      # but smaller than the largest number we have checked
      false
    end

    sqrt = Math.sqrt(n)
    sqrt_floor = sqrt.floor

    # if sqrt and sqrt_floor are the same,
    # n has an integer sqrt root and isn't prime
    return false if sqrt == sqrt_floor

    # we only have to check prime divisors
    @primes.each do |p|
      return false if n % p == 0
    end

    # we only need to keep going if we are unsure if there are
    # more primes between the last number we check and the largest
    # possible prime divisor of n, sqrt_floor
    if sqrt_floor > @max_checked
      # start with the largest prime and go until
      # we hit the sqrt_floor
      ((@primes.last)..sqrt_floor).each do |i|
        return false if n % i == 0
      end
    end

    true
  end

  #

  def factors(n)
    current = n
    factors = []

    while current != 1
      if prime?(current)
        p = current
        factors << p
        current /= p
      else
        sqrt_floor = Math.sqrt(current).floor
        max(sqrt_floor).each do |p|
          if (current % p).zero?
            factors << p
            current /= p
            break
          end
        end
      end
    end

    factors
  end

  private

  def add(p)
    @primes << p
    @primes_lookup[p] = @primes.length - 1

    p
  end
end
