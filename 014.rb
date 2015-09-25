# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.

class Integer

  def next_collatz
    self % 2 == 0 ? (self / 2) : (3 * self + 1)
  end

  def collatz_chain_length
    len = 1

    i = self
    while i != 1
      i = i.next_collatz
      len += 1
    end

    len
  end

  def collatz_chain
    chain = [ self ]

    while chain.last != 1
      chain << chain.last.next_collatz
    end

    chain
  end

end

max_length = 1
max_num = 1

(2..1000000).each do |i|
  current_length = i.collatz_chain_length
  if current_length > max_length
    max_length = current_length
    max_num = i
  end
end

puts "#{max_num} => #{max_length}"
