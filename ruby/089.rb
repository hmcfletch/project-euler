# For a number written in Roman numerals to be considered valid there are basic
# rules which must be followed. Even though the rules allow some numbers to be
# expressed in more than one way there is always a "best" way of writing a
# particular number.

# For example, it would appear that there are at least six ways of writing the
# number sixteen:

# IIIIIIIIIIIIIIII
# VIIIIIIIIIII
# VVIIIIII
# XIIIIII
# VVVI
# XVI

# However, according to the rules only XIIIIII and XVI are valid, and the last
# example is considered to be the most efficient, as it uses the least number of
# numerals.

# The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains
# one thousand numbers written in valid, but not necessarily minimal, Roman
# numerals; see About... Roman Numerals for the definitive rules for this problem.

# Find the number of characters saved by writing each of these in their minimal form.

# Note: You can assume that all the Roman numerals in the file contain no more
# than four consecutive identical units.

# More info: https://projecteuler.net/about=roman_numerals

# I = 1
# V = 5
# X = 10
# L = 50
# C = 100
# D = 500
# M = 1000

ROMAN_TO_I = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}

I_TO_ROMAN = {
  1    => 'I',
  5    => 'V',
  10   => 'X',
  50   => 'L',
  100  => 'C',
  500  => 'D',
  1000 => 'M'
}

class RomanHelper

  class << self

    def compare(a, b)
      ROMAN_TO_I[a.upcase] <=> ROMAN_TO_I[b.upcase]
    end

    def parse(roman)
      numerals = roman.split('')

      # puts numerals.inspect

      tokens = []
      current_token = []

      numerals.each do |n|
        n = n.upcase
        # puts "= #{n} ="
        # puts "  current_token: #{current_token.inspect}"
        # puts "  #{n} <=> #{current_token.last}"

        if current_token.empty?
          current_token << n
        elsif compare(n, current_token.last) < 0 # n < current_token.last
          # we have moved on to the next token
          if current_token.uniq.length == 1
            tokens.concat(current_token.collect { |a| [ a ] })
          elsif current_token.length > 1
            tokens << current_token
          end
          current_token = []
          current_token << n
        elsif compare(n, current_token.last) == 0 # n == current_token.last
          # we might be in a subtractive combination (I's in IIV)
          # or the last few tokens (the I's in XIII)
          current_token << n
        else # compare(n, current_token.last) > 0  # n > current_token.last
          # this is the end of a subtractive combintation
          current_token << n
          if current_token.uniq.length == 1
            tokens.concat(current_token.collect { |a| [ a ] })
          elsif current_token.length > 1
            tokens << current_token
          end
          current_token = []
        end
      end

      # add the last token
      if current_token.uniq.length == 1
        tokens.concat(current_token.collect { |a| [ a ] })
      elsif current_token.length > 1
        tokens << current_token
      end

      tokens
    end

    # Numerals must be arranged in descending order of size.
    # M, C, and X cannot be equalled or exceeded by smaller denominations.
    # D, L, and V can each only appear once.
    # Only one I, X, and C can be used as the leading numeral in part of a subtractive pair.
    # I can only be placed before V and X. IC LXXXXIX
    # X can only be placed before L and C.
    # C can only be placed before D and M.
    def is_valid?
    end

    def to_i(roman)
      num = 0
      parse(roman).each do |t|
        if t.length == 1
          num += ROMAN_TO_I[t[0]]
        else
          s = ROMAN_TO_I[t[t.length - 1]]
          ((t.length - 2)..0).each do |i|
            s -= ROMAN_TO_I[t[i]]
          end
          num += s
        end
      end
      num
    end

    def to_roman_helper(current, tokens, base, base_r, base_5r, base_10r)
      base_9 = 9 * base

      if current >= base_9
        tokens << base_r
        tokens << base_10r
        current -= base_9
      end

      base_5 = 5 * base

      if current >= base_5
        tokens << base_5r
        current -= base_5
      end

      base_4 = 4 * base

      if current >= base_4
        tokens << base_r
        tokens << base_5r
        current -= base_4
      end

      while current >= base
        tokens << base_r
        current -= base
      end

      [ current, tokens ]
    end

    def to_roman(i)
      tokens = []
      current = i

      while current >= 1000
        tokens << 'M'
        current -= 1000
      end

      current, tokens = to_roman_helper(current, tokens, 100, 'C', 'D', 'M')
      current, tokens = to_roman_helper(current, tokens, 10, 'X', 'L', 'C')
      current, tokens = to_roman_helper(current, tokens, 1, 'I', 'V', 'X')

      tokens.join
    end

  end

end

romans = []

f = File.open("../data_files/p089_roman.txt", "r") do |f|
  f.each_line do |line|
    romans << line.chomp
  end
end

puts romans.length

tally = 0

romans.each do |r|
  i = RomanHelper.to_i(r)
  new_r = RomanHelper.to_roman(i)
  savings = r.length - new_r.length
  tally += savings
  puts "#{r} => #{i} => #{new_r} => #{savings}"
end

puts tally
