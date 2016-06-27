# A common security method used for online banking is to ask the user for three
# random characters from a passcode. For example, if the passcode was 531278,
# they may ask for the 2nd, 3rd, and 5th characters; the expected reply
# would be: 317.

# The text file, keylog.txt, contains fifty successful login attempts.

# Given that the three characters are always asked for in order, analyse the file
# so as to determine the shortest possible secret passcode of unknown length.

keys = []

f = File.open("../data_files/p079_keylog.txt", "r") do |f|
  f.each_line do |line|
    keys << line.chomp unless line.chomp == ''
  end
end

basic_graph = {}

tree = {}

possible_digits = []

all_attempts = []

keys.sort.each do |key|
  digits = key.split('').collect { |d| d.to_i }
  all_attempts << digits
  possible_digits.concat(digits)
  # puts digits.inspect

  d1 = digits[0]
  d2 = digits[1]
  d3 = digits[2]

  [ [ d1, d2 ], [ d2, d3 ] ].each do |a, b|
    bucket = basic_graph.has_key?(a) ? basic_graph[a] : []
    bucket = bucket.include?(b) ? bucket : bucket.push(b).sort
    basic_graph[a] = bucket
  end

  sub_tree = tree.has_key?(d1) ? tree[d1] : {}
  leaves = sub_tree.has_key?(d2) ? sub_tree[d2] : []
  bucket = leaves.include?(d3) ? leaves : leaves.push(d3).sort
  sub_tree[d2] = leaves
  tree[d1] = sub_tree
end

# puts basic_graph.inspect

puts possible_digits.uniq.sort.inspect

puts

basic_graph.keys.sort.each do |k|
  puts "#{k} => #{basic_graph[k].inspect}"
end

# puts tree.inspect

puts

tree.keys.sort.each do |k|
  puts "#{k} =>"
  tree[k].keys.sort.each do |j|
    puts "    #{j} => #{tree[k][j].inspect}"
  end
end


def valid?(guess, digits)
  puts guess.inspect

  digits.each do |d|
    i1 = guess.index(d[0])
    if i1.nil?
      puts "i1"
      puts d.inspect
      return false
    end

    i2 = guess.slice(i1, guess.length).index(d[1])
    if i2.nil?
      puts "i2"
      puts d.inspect
      return false
    end

    i3 = guess.slice(i1, guess.length).index(d[2])
    if i3.nil?
      puts "i3"
      puts d.inspect
      return false
    end
  end

  true
end

def no_incoming_edges(g)
  v = g.values.flatten.uniq
  g.keys.reject { |a| v.include?(a) }
end

def remove_vertex(graph, v)
  graph.delete(v)
  graph.keys.each do |k|
    n = graph[k].reject { |i| i == v }
    n.size == 0 ? graph.delete(k) : graph[k] = n
  end
  graph
end

graph = basic_graph

tokens = []

s = no_incoming_edges(graph)

puts 'asdadsasd'
puts s.inspect

while s.length > 0
  puts '+++++++'
  puts "s: #{s.inspect}"
  puts graph.inspect
  n = s.shift

  puts "== #{n}"
  tokens << n
  graph.delete(n)
  s = s.concat(no_incoming_edges(graph)).uniq
  puts graph.inspect
end

# the above isn't handling the final piece correctly
# so just add it here
puts tokens.concat(['0']).join

# puts valid?(tokens.reverse, all_attempts)
