# The nth term of the sequence of triangle numbers is given
# by, t_n = ½n(n+1); so the first ten triangle numbers are:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# By converting each letter in a word to a number corresponding
# to its alphabetical position and adding these values we form a word
# value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t_10.
# If the word value is a triangle number then we shall call the word a
# triangle word.
#
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text
# file containing nearly two-thousand common English words, how many are
# triangle words?

LETTERS = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z).freeze
LETTER_SCORES = Hash[(1..26).collect { |i| [LETTERS[i - 1], i] }].freeze

MAX_NUM = 1000
TRIANGLE_NUMS = Hash[(1..MAX_NUM).collect { |i| [(0.5 * i * (i + 1)).to_i, i] }]

words_array = []

File.open('../data_files/p042_words.txt', 'r') do |f|
  f.each_line do |line|
    words_array << line.chomp
  end
end

words = words_array[0].split(',').map! { |n| n.tr('"', '') }.sort

tally = 0

words.each do |word|
  puts "+++ #{word}"
  letters = word.split('')
  puts "  #{letters.inspect}"
  letter_scores = letters.collect { |l| LETTER_SCORES[l] }
  puts "  #{letter_scores.inspect}"
  word_score = letter_scores.sum

  puts "#{word} => #{word_score}"

  tally += 1 if TRIANGLE_NUMS.key?(word_score)
end

puts tally
