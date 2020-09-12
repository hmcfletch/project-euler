# A positive fraction whose numerator is less than its denominator is called a proper fraction.
# For any denominator, d, there will be d−1 proper fractions; for example, with d = 12:
# 1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12 .

# We shall call a fraction that cannot be cancelled down a resilient fraction.
# Furthermore we shall define the resilience of a denominator, R(d), to be the ratio of its
# proper fractions that are resilient; for example, R(12) = 4/11 .
# In fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10 .

# Find the smallest denominator d, having a resilience R(d) < 15499/94744 .

require './helpers/prime_helper'
require './helpers/combinatorics_helper'
# require 'set'

TARGET = 15499.to_f / 94744

prime_factors_cache = {}

class PrimeCache

  def initialize(ph)
    @ph = ph || PrimeHelper.new
    @prime_factors_cache = {}
  end

  def ph
    @ph
  end

  def prime_factors(n)
    unless @prime_factors_cache.has_key?(n)
      @prime_factors_cache[n] = @ph.prime_factors(n)
    end

    @prime_factors_cache[n]
  end

end

def is_resilient?(pc, n, d)
  (pc.prime_factors(n) & pc.prime_factors(d)).empty?
end

def num_resilience_fractions(pc, d, verbose = false)
  puts "+++ #{d} +++" if verbose
  # return d-1 if pc.ph.is_prime?(d)
  tally = 0

  #####

  pf = pc.prime_factors(d).sort
  puts "  = prime factors: #{pf.inspect} +++" if verbose

  factors = pf.uniq.sort
  puts "  = uniq prime factors: #{factors.inspect} +++" if verbose

  # s = Set.new(factors)

  # tally = 1
  # pc.ph.primes_max(d-1).each do |p|
  #   next if s.include?(p)
  #   max = (d-1) / p
  #   # puts "+++ #{p} => #{max}" if verbose
  #   tally += 1
  #   pc.ph.primes_max(max).each do |p2|
  #     next if p2 < p
  #     next if s.include?(p2)
  #     # puts [p, p2].inspect if verbose
  #     tally += 1
  #   end
  # end

  ######

  psf = CombinatoricsHelper.power_set(pf)
  ps = CombinatoricsHelper.power_set(factors)

  puts psf.inspect if verbose
  puts ps.inspect if verbose

  num = 0
  ps.each do |s|
    next if s.empty?
    # next if s.length == factors.length

    if s.length == 1
      a = (d-1) / s[0]
      num += a
      puts "  + #{a} => #{s[0]} :: #{num}" if verbose
    else
      v = s.inject(1, :*)
      a = (d-1) / v
      num -= a
      puts "  - #{a} => #{v} :: #{s.inspect}:: #{num}" if verbose
    end
  end

  tally = d - 1 - num

  ######

  # multiples_of_factors = 0
  # factors.each do |f|
  #   v = (d-1) / f
  #   puts "  #{f} :: #{d-1}/#{f} = #{v}" if verbose
  #   multiples_of_factors += v
  # end

  # tally = d - 1 - multiples_of_factors

  if verbose
    nons = []
    factors.each do |f|
      v = (d-1) / f
      (1..v).each do |i|
        nons << f*i
      end
    end
    puts "  nons:"
    puts "  #{nons.sort.inspect}"
    puts "  uniq nons:"
    puts "  #{nons.uniq.sort.inspect}"
    len = nons.length
    puts "  len: #{len}"
    uniq_length = nons.uniq.length
    puts "  uniq: #{uniq_length}"
    puts "  diff: #{len - uniq_length}"
    # puts "  mc: #{CombinatoricsHelper.n_multichoose_k(pf.length, factors.length)}"

    # (1..pf.length).each do |n|
    #   (1..n).each do |k|
    #     puts "  #{n} choose #{k} = #{CombinatoricsHelper.n_choose_k(n, k)}"
    #     puts "  #{n} multi choose #{k} = #{CombinatoricsHelper.n_multichoose_k(n, k)}"
    #   end
    # end
  end
  puts "  tally: #{tally}" if verbose
  # puts "  #{d} :: #{d - 1 - uniq_length}" if verbose # CORRECT
  # puts "  #{CombinatoricsHelper.n_choose_k(pf.length, pf.length-1)}"

  #####

  # factors = pc.prime_factors(d).uniq
  # (1..(d-1)).each do |i|
  #   tally += 1 unless factors.any? { |p| i % p == 0 }
  # end

  #####

  tally
end

def resilience(pc, d)
  # puts "== resilience :: #{d}"
  num = num_resilience_fractions(pc, d)
  # puts "  + #{d} => #{num} / #{d-1}"
  num.to_f / (d-1)
end

puts "target: #{TARGET}"

ph = PrimeHelper.new
pc = PrimeCache.new(ph)

######

# i = 96
# b = num_resilience_fractions(pc, i, true)
# a = []
# (1..(i-1)).each do |j|
#   a << j if is_resilient?(pc, j, i)
# end
# puts "-=-= #{a.length} :: #{a.inspect}"

# exit

######

fails = []
(2..200).each do |i|
# (60..60).each do |i|
  b = num_resilience_fractions(pc, i, true)
  a = []
  (1..(i-1)).each do |j|
    a << j if is_resilient?(pc, j, i)
  end
  puts "-=-= #{a.length} :: #{a.inspect}"
  fails << [ i, a.length - b ] if a.length != b
end

puts
puts
puts '++++++'
puts fails.inspect

exit

######

n = 16
v = 0
(1..(n-1)).each do |i|
  b = is_resilient?(pc, i, n)
  v += 1 if b
  puts "#{i}/#{n} => #{b}"
end

puts v

puts num_resilience_fractions(pc, n, true)

exit

#####

# prime the pump
primer = 100000
puts 'Priming primes...'
pc.ph.primes_max!(primer)
puts 'Done priming.'

# (2..primer).each do |i|
#   prime_factors_cache[i] = pc.ph.prime_factors(i)
# end

# puts resilience(pc, 10)
# puts resilience(pc, 12)

i = 2
current_resilience = resilience(pc, i)
min_resilience = current_resilience

while current_resilience >= TARGET
# while i < 20
  i += 1

  puts i if i % 1000 == 0
  current_resilience = resilience(pc, i)

  if current_resilience < min_resilience
    min_resilience = current_resilience
    diff = min_resilience - TARGET
    puts "** #{i} => #{diff} **"
  end
end

puts i
