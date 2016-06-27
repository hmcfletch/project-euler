# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over
# five-thousand first names, begin by sorting it into alphabetical order. Then working out the
# alphabetical value for each name, multiply this value by its alphabetical position in the
# list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a
# score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?

LETTERS = %w( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z )
LETTER_SCORES = {}

LETTERS.each_with_index { |letter, i| LETTER_SCORES[letter] = i + 1 }

def name_value(name)
  name.split(//).inject(0) do |memo, n|
    memo += LETTER_SCORES[n]
  end
end

name_array = []

f = File.open("../data_files/p022_names.txt", "r") do |f|
  f.each_line do |line|
    name_array << line
  end
end

names = name_array[0].split(",").map! { |n| n.gsub('"', '') }.sort

sum = 0

names.each_with_index do |name, i|
  sum += (name_value(name) * (i + 1))
end

puts sum
