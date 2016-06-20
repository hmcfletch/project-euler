class PrimeHelper

  def initialize
    @primes = [ 2 ]
    @max_checked = 2
  end

  #

  def cached_primes
    @primes
  end

  def max_checked
    @max_checked
  end

  #

  # return the first n primes
  def primes_first(n)
    primes_first!(n)
    @primes.first(n)
  end

  # generate the first n primes
  def primes_first!(n)
    while @primes.length < n
      next_prime!
    end

    true
  end

  # return primes less or equal to n
  def primes_max(n)
    primes_max!(n)

    # find the index of the prime less than or equal to n
    idx = if @primes.respond_to?(:bsearch_index)
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

  # generate primes less or equal to n
  def primes_max!(n)
    # we only need to do something if n is greater than
    # the largest number we have checked
    if n > @max_checked
      # start at the largest number we have checked
      (@max_checked..n).each do |i|
        @primes << i if is_prime?(i)
      end
      @max_checked = n
    end

    true
  end

  # return the next prime
  def next_prime
    next_prime!
    @primes.last
  end

  # generate the next prime
  def next_prime!
    i = @max_checked
    current_max = @primes.last
    while current_max == @primes.last
      i += 1
      @primes << i if is_prime?(i)
    end
    @max_checked = @primes.last

    true
  end

  # check if n is prime
  def is_prime?(n)
    if n < @primes.last
      # we have already have a prime greater than n,
      # check if this is in our set
      return !@primes.bsearch { |p| n <=> p }.nil?
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

end
